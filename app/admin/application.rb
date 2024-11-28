# app/admin/application.rb
ActiveAdmin.setup do |config|
  # Skip authentication for the login page
  config.before_action do
    if request.path != new_admin_user_session_path && (current_admin_user.nil? || current_admin_user.role != "admin")
      redirect_to root_path, alert: "You do not have permission to access this page."
    end
  end
end
