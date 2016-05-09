class Folder < ActiveRecord::Base
	include Rails.application.routes.url_helpers

	validates :name, presence: true

	acts_as_tree

	before_save :set_parent_id

	attr_reader :url


	def url
		admin_folder_view_path(id)
	end

	def set_parent_id
		if self.parent_id == 0
			self.parent_id = nil
		end

		if parent_id_changed? && children_ids.include?(parent_id)
			self.parent_id = parent_id_was
		end
	end

	def self.get_folders
		by_parent_id.all.map {|child| child.get_tree }
	end

	def get_tree
		hash = {
			id: id,
			text: name,
		}
		if children.present?
			hash[:nodes] = children.map { |child| child.get_tree }
		end
		hash
	end

	def parent_tree(folders = [])
		folders << {id: id, name: name, url: url}
		if parent.present?
			parent.parent_tree(folders)
		end
		folders
	end

	def children_ids(ids = [])
		children.each do |child|
			ids << child.id
			child.children_ids(ids)
		end
		ids
	end

	scope :by_parent_id, -> (id = nil) { where(parent_id: id) }


end