class UploadFile < ActiveRecord::Base
	include Rails.application.routes.url_helpers
	mount_uploader :file, FileUploader

	attr_accessor :url

	validates :description, presence: true

	def url
		admin_files_download_path(id)
	end

	scope :by_parent_id, -> (id = nil) { where(folder_id: id) }

end