class FilesController < ApplicationController
  before_action :authenticate_user!

  def get_modal
    render :file_webix_add, layout: nil
  end

  def store
    attributes = params.require(:file_upload).permit(:description, :file, :folder_id)
    file = UploadFile.create(attributes)
    render text: 'Файл загружен'
  end

  def destroy
    @file = UploadFile.find(params[:id])
    @file.destroy
    render nothing: true
  end

  def update
    @file = UploadFile.find(params[:id])
    attributes = params.permit(:description, :file, :folder_id)
    @file.update(attributes)
    if attributes[:file].present?
      render text: 'Файл обновлен'
    else
      render partial: 'files/webix_item', locals: { file: @file }
    end
  end

  def get_modal_for_update
    @file = UploadFile.find(params[:id])
    render partial: 'files/file_webix_update', locals: { file: @file }
  end

  def download
    file = UploadFile.find(params[:id])
    send_file file.file.path
  end
end
