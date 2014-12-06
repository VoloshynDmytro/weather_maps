class Api::ApplicationController < ActionController::API
  include ActionController::ImplicitRender

  #TODO add errorInterceptor for angular
  rescue_from CanCan::AccessDenied do |exception|
    if current_user
      render(json: {errors: exception.message}, status: 403)
    else
      render(json: {errors: exception.message}, status: 401)
    end
  end
end