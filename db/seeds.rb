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

[
  { name: 'Ontario', gst: 0.0, pst: 0.0, hst: 13.0 },
  { name: 'British Columbia', gst: 5.0, pst: 7.0, hst: 0.0 },
  { name: 'Alberta', gst: 5.0, pst: 0.0, hst: 0.0 },
  { name: 'Quebec', gst: 5.0, pst: 9.975, hst: 0.0 },
  { name: 'Nova Scotia', gst: 0.0, pst: 0.0, hst: 15.0 },
  { name: 'New Brunswick', gst: 0.0, pst: 0.0, hst: 15.0 },
  { name: 'Manitoba', gst: 5.0, pst: 7.0, hst: 0.0 },
  { name: 'Prince Edward Island', gst: 0.0, pst: 0.0, hst: 15.0 },
  { name: 'Saskatchewan', gst: 5.0, pst: 6.0, hst: 0.0 },
  { name: 'Newfoundland and Labrador', gst: 0.0, pst: 0.0, hst: 15.0 },
  { name: 'Northwest Territories', gst: 5.0, pst: 0.0, hst: 0.0 },
  { name: 'Yukon', gst: 5.0, pst: 0.0, hst: 0.0 },
  { name: 'Nunavut', gst: 5.0, pst: 0.0, hst: 0.0 }
].each do |province_data|
  Province.find_or_create_by(name: province_data[:name]) do |province|
    province.gst = province_data[:gst]
    province.pst = province_data[:pst]
    province.hst = province_data[:hst]
  end
end
