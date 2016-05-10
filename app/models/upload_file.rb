class UploadFile < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  mount_uploader :file, FileUploader

  attr_accessor :url

  scope :by_parent_id, -> (id = nil) { where(folder_id: id) }

  scope :roots, -> { by_parent_id }

  before_save :set_parent_id

  validates :description, presence: true

  def url
    admin_files_download_path(id)
  end

  def set_parent_id
    self.parent_id = nil if parent_id == 0
  end
end
