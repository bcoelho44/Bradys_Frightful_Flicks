class ApplicationController < ActionController::Base
  def authenticate_admin_user!
    unless current_admin_user
      redirect_to new_admin_user_session_path, alert: 'Please log in as an admin to access this section.'
    end
  end
end
