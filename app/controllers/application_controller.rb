class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout "app"

  #before_action :require_login

  # private
  # def require_login
  # 	unless logged_in?
  # 		redirect_to users_path
  # 	end
  # end
end
