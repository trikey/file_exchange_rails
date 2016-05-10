class FoldersController < ApplicationController
  before_action :authenticate_user!
  def index
    # Folder.first.children.create(name: 'test')
    @folders = Folder.roots
    @parentFolder = nil
    @breadcrumbs = []
    @files = UploadFile.roots.all
    render :list
  end

  def destroy
    @folder = Folder.find(params[:id])
    @folder.destroy
    render nothing: true
  end

  def get_tree
    json = [{
      id: 0,
      text: 'Корень',
      nodes: Folder.get_tree
    }]
    render json: json
  end

  def store
    @folder = Folder.new(folder_params)
    @folder.save
    render partial: 'folders/webix_item', locals: { folder: @folder }
  end

  def update
    @folder = Folder.find(params[:id])
    @folder.update(folder_params)
    render partial: 'folders/webix_item', locals: { folder: @folder }
  end

  def view_folder
    @folders = Folder.by_parent_id(params[:id])
    @parentFolder = params[:id]
    @breadcrumbs = Folder.find(params[:id]).parent_tree.reverse
    @files = UploadFile.by_parent_id(params[:id])
    render :list
  end

  private

  def folder_params
    params.permit(:name, :description, :parent_id)
    end
end
