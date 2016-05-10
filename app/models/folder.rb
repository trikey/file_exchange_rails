class Folder < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  scope :by_parent_id, -> (id = nil) { where(parent_id: id) }

  scope :roots, -> { by_parent_id }

  validates :name, presence: true

  acts_as_tree

  before_save :set_parent_id

  attr_reader :url

  def url
    admin_folder_view_path(id)
  end

  def set_parent_id
    self.parent_id = nil if parent_id == 0

    if parent_id_changed? && children_ids.include?(parent_id)
      self.parent_id = parent_id_was
    end
  end

  def self.get_tree
    by_parent_id.all.map(&:get_tree)
  end

  def get_tree
    hash = {
      id: id,
      text: name
    }
    hash[:nodes] = children.map(&:get_tree) if children.present?
    hash
  end

  def parent_tree(folders = [])
    folders << { id: id, name: name, url: url }
    parent.parent_tree(folders) if parent.present?
    folders
  end

  def children_ids(ids = [])
    children.each do |child|
      ids << child.id
      child.children_ids(ids)
    end
    ids
  end
end
