class ApplicationController < ActionController::Base
  # Ensure permitted parameters are configured for Devise controllers
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Restrict admin access for Active Admin
  def authenticate_admin_user!
    unless current_admin_user.present?
      redirect_to new_admin_user_session_path, alert: 'Access denied: Admins only.'
    end
  end

  protected

  # Allow additional parameters for Devise sign-up and account update
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :address, :province_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :address, :province_id])
  end
end
