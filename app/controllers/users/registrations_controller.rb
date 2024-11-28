# app/controllers/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
  # Add any custom logic for the registration process here, such as additional fields
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Permit additional parameters for registration (e.g., province_id)
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:province_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:province_id])
  end
end
