class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # devise_parameter_sanitizer.permit(:sign_up, :keys => [:username, :avatar_url])

    # devise_parameter_sanitizer.permit(:account_update, :keys => [:avatar_url])
  end

  def after_sign_in_path_for(resource)
    root_path
  end
end
