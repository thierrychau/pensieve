module ApplicationController::Punditable
  extend ActiveSupport::Concern

  include Pundit::Authorization

  included do
    after_action :verify_authorized, unless: :devise_controller?
    after_action :verify_policy_scoped, only: :index, unless: :devise_controller?
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back(fallback_location: root_path)
  end
end
