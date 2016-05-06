class UsersController < ApplicationController
  def index
  	@users = User.paginate(:page => params[:page], :per_page => 10)
  end

  def editUser
  	@user = User.find(params[:id])
  end

  def create
  	@form_created = 1
  end

  def storeUser
  	@user = User.new(user_params)
  	if @user.save
  		redirect_to users_path
  	else
	  	@form_created = 1
  		render 'create'
  	end
  end

  def destroy
  	User.find(params[:id]).destroy
  	redirect_to users_path
  end

  def updateUser
  	@user = User.find(params[:id])
	  if @user.update(user_params)
	    redirect_to users_path
	  else
	    render 'editUser'
	  end
  end

  def search
    q = params[:query]
    if q.present?
      @users = User.find_all_by_name(q).all.paginate(:page => params[:page], :per_page => 10)
    else
      @users = User.paginate(:page => params[:page], :per_page => 10)
    end
    
    render 'index'
  end

  private
	  def user_params
	    params.require(:user).permit(:fio, :email, :organisation, :password, :password_confirmation, :isModerator, :isAdmin, :canAccess)
	  end  	
end