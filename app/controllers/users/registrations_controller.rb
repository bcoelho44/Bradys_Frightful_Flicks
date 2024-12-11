class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  def create
    super do |resource|
      # If the user has no address, create one with the provided fields
      if resource.address.nil?
        resource.create_address(address_params)
      end
    end
  end

  def update
    super do |resource|
      # Update address if it exists, or create a new one
      if resource.address.nil?
        resource.create_address(address_params)
      else
        resource.address.update(address_params)
      end
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :province_id,
      address_attributes: [:street, :city, :postal_code, :province_id]
    ])
    devise_parameter_sanitizer.permit(:account_update, keys: [
      :province_id,
      address_attributes: [:street, :city, :postal_code, :province_id]
    ])
  end

  private

  def address_params
    params.require(:user).permit(:street, :city, :postal_code, :province_id)
  end
end
