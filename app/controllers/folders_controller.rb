class FoldersController < ApplicationController

	def index
		@folders = Folder.all
		@parentFolder = 'NULL'
		@breadcrumbs = []

		render 'list'
	end

	def destroy
	end

	def create
	end

	def getTree
	end

	def store
		@folder = Folder.new(folder_params)
		@folder.save
		render partial: 'folders/webix_item', locals: { folder: @folder }
	end

	def edit
	end

	def update
	end

	def viewFolder
	end

	private
	  def folder_params
	    params.permit(:name, :description, :parent_id)
	  end  
end