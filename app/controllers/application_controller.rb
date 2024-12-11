class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Custom after sign-in path
  def after_sign_in_path_for(resource)
    if resource.is_a?(AdminUser)
      admin_dashboard_path # Redirect admin users to the ActiveAdmin dashboard
    else
      root_path # Redirect regular users to the homepage
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:province_id, address_attributes: [:street, :city, :postal_code, :province_id]])
  end

  def authenticate_admin_user!
    # Only check if it's an AdminUser, not a regular User
    if request.path != new_admin_user_session_path && current_admin_user.nil?
      redirect_to root_path, alert: "You do not have permission to access this page."
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:province_id])  # Permit province_id during sign-up
  end
end
