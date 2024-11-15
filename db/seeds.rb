# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Admin User
AdminUser.find_or_create_by(email: 'admin@example.com') do |admin|
  admin.password = 'password'
  admin.password_confirmation = 'password'
end

# Static Page for About
StaticPage.find_or_create_by(slug: "about") do |page|
  page.title = "About Us"
  page.content = "Welcome to Brady's Frightful Flicks! This is the About page."
end

StaticPage.find_or_create_by(slug: "contact") do |page|
  page.title = "Contact Us"
  page.content = "This is the contact page content. Add your contact details here."
end
