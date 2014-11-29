  class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include ApplicationHelper
  respond_to :json, :html
  protect_from_forgery with: :exception

  after_filter :set_csrf_cookie_for_ng

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  protected
  def verified_request?
    super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
  end

  #before_filter do
  #  resource = controller_path.singularize.gsub('/', '_').to_sym
  #  method = "#{resource}_params"
  #  params[resource] &&= send(method) if respond_to?(method, true)
  #end

  #rescue_from CanCan::AccessDenied do |exception|
  #    flash[:error] = exception.message
  #    redirect_to new_user_session_path
  #end

end
