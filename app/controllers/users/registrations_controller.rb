class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Permit additional parameters for account update
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:province_id, address_attributes: [:street, :city, :postal_code]])
  end
end
