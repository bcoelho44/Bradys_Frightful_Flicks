class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:province_id, addresses_attributes: [:street, :city, :postal_code]])
    devise_parameter_sanitizer.permit(:account_update, keys: [:province_id, addresses_attributes: [:street, :city, :postal_code]])
  end
end
