class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  private

  # Whitelist additional fields for sign-up
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :email, :password, :password_confirmation, :province_id,
      address_attributes: [:street, :city, :postal_code]
    ])
  end
end
