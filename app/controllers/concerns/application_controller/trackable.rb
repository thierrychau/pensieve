module ApplicationController::Trackable
  extend ActiveSupport::Concern

  included do
    after_action :track_action
  end

  protected

  def track_action
    ahoy.track "Ran action", request.path_parameters
  end
end
