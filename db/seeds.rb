# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html

puts 'seeding: users'
user = User.find_by(email: ENV['ADMIN_EMAIL']) || User.create!(:name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup)
puts 'user: ' << user.name
user.admin!

puts 'seed locations'
20.times do
  rnd_lat = rand(49.55...49.85)
  rnd_lng = rand(24.04...24.20)
  rnd_num = rand(0..200)
  Location.create!(:name => "Location#{rnd_num}", :city => "Lviv", :country => "Ukraine", :district => "Lviv district",
                   :address => "Address #{rnd_num}", :lat => rnd_lat, :lng => rnd_lng, :user_id => user.id)
end


