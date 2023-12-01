class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  after_action :verify_authorized, unless: :devise_controller?
  after_action :verify_policy_scoped, only: :index, unless: :devise_controller?

  include Pundit::Authorization
  include Devisable

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  
  private
    def after_sign_in_path_for(resource)
      root_path
    end

    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      redirect_back(fallback_location: root_path)
    end
end
