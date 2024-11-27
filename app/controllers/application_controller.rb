class ApplicationController < ActionController::Base
  # Ensure permitted parameters are configured for Devise controllers
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Authenticate admin user for specific admin actions
  def authenticate_admin_user!
    unless current_admin_user
      redirect_to new_admin_user_session_path, alert: 'Please log in as an admin to access this section.'
    end
  end

  protected

  # Allow additional parameters for Devise sign-up and account update
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:role])
  end
end
