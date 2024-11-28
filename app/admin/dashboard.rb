# frozen_string_literal: true

ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    # Welcome message
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    # Admin users table
    div class: "admin-users-container" do
      h2 "Admin Users"

      # Display a table of all admin users
      table class: "table is-fullwidth" do
        thead do
          tr do
            th "ID"
            th "Email"
            th "Created At"
            th "Role"
          end
        end
        tbody do
          AdminUser.all.each do |admin|
            tr do
              td admin.id
              td admin.email
              td admin.created_at
              td admin.role
            end
          end
        end
      end
    end

    # Logout button
    div class: "logout-button" do
      link_to "Logout", destroy_admin_user_session_path, method: :delete, class: "button is-danger"
    end
  end
end
