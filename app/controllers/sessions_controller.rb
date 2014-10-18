class SessionsController < Devise::SessionsController
  protect_from_forgery except: :create

  protected
  #def after_sign_in_path_for(resource_or_scope)
    #redirect_target =  current_user.admin? ? admin_dashboard_path : stored_location_for(resource_or_scope) || root_path
  #end

end
