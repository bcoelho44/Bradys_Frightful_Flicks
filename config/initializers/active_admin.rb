# config/initializers/active_admin.rb

ActiveAdmin.setup do |config|
  # Make sure the correct user method is called
  config.current_user_method = :current_admin_user

  # The authentication method (ensure this matches your setup)
  config.authentication_method = :authenticate_admin_user!
end
