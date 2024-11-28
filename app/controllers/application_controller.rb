class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Custom after sign-in path
  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_dashboard_path # or any admin page you'd like to redirect to
    else
      root_path
    end
  end

  protected

  def authenticate_admin_user!
    if request.path != new_admin_user_session_path && (current_admin_user.nil? || current_admin_user.role != "admin")
      redirect_to root_path, alert: "You do not have permission to access this page."
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:province_id])
  end
end
