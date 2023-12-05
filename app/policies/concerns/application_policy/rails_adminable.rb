module ApplicationPolicy::RailsAdminable
  extend ActiveSupport::Concern

  def dashboard?
    user.admin?
  end

  def export?
    user.admin?
  end

  def history?
    user.admin?
  end

  def show_in_app?
    user.admin?
  end
end
