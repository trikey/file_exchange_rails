class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only

  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def edit
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path
    else
      render 'new'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_path
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path
    else
      render 'edit'
    end
  end

  def search
    q = params[:query]
    @users = if q.present?
               User.find_all_by_name(q).all
             else
               User
             end

    @users = @users.paginate(page: params[:page], per_page: 10)

    render 'index'
  end

  private

  def user_params
    params.require(:user).permit(:fio, :email, :organisation, :password, :password_confirmation, :isModerator, :isAdmin, :canAccess)
   end

  def admin_only
    redirect_to admin_folders_path unless current_user.isAdmin?
  end
end
