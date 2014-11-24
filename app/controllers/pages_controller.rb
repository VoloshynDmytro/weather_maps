class PagesController < ApplicationController
  #before_action :redirect_loggedin, only: [:home]

  def home
  end

  private
  def redirect_loggedin
    redirect_to(current_user.admin? ? admin_dashboard_path : dashboard_path) if user_signed_in?
  end
end
