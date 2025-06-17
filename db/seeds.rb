# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb
require 'faker'

Attendance.destroy_all
Event.destroy_all
User.destroy_all

ActiveRecord::Base.connection.reset_pk_sequence!('users')
ActiveRecord::Base.connection.reset_pk_sequence!('events')
ActiveRecord::Base.connection.reset_pk_sequence!('attendances')

puts "Création de 2 utilisateurs..."

# users = 2.times.map do
#   first_name = Faker::Name.first_name.downcase
#   last_name = Faker::Name.last_name.downcase
#   User.create!(
#     email: "#{first_name}.#{last_name}@yopmail.com",
#     password: "fakepassword",
#     password_confirmation: "fakepassword",
#     first_name: first_name.capitalize,
#     last_name: last_name.capitalize,
#     description: Faker::Lorem.sentence(word_count: 10)
#   )
# end

users = 2.times.map do |i|

  User.create!(
    email: "pandauser#{i+1}@yopmail.com",
    password: "fakepassword",
    password_confirmation: "fakepassword",
    first_name: "Panda#{i+1}",
    last_name: "User#{i+1}",
    description: Faker::Lorem.sentence(word_count: 10)
  )
end



puts "Création de 5 événements..."

events = 5.times.map do
  Event.create!(
    start_date: Faker::Time.forward(days: 30, period: :morning),
    duration: [60, 90, 120, 180].sample,
    title: Faker::Book.title,
    description: Faker::Lorem.paragraph(sentence_count: 5),
    price: rand(20..100),
    location: Faker::Address.city,
    admin_id: users.sample.id
  )
end

puts "Création des participations (attendances)..."

2.times do
  Attendance.create!(
    user_id: users.sample.id,
    event_id: events.sample.id,
    stripe_customer_id: "cus_#{Faker::Alphanumeric.alphanumeric(number: 10)}"
  )
end

puts "Seed terminée avec plusieurs entrées."
