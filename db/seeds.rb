# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


puts "Creating store"
store = Store.create(
  name: "Corner Store Network",
  address: "42 Regent Street",
  suburb: "Oakleigh",
  state: "Victoria",
  postcode: "3250"
)

puts "creating admin account"
admin = User.create(
  name: "Admin",
  email: "admin@gmail.com",
  password_digest: "password",
  key: Faker::Alphanumeric.alphanumeric(number: 10),
  user_type: 2,
  store: store
)

5.times do |i|
  puts "creating user #{i}"
  user = User.create(
    name: Faker::Name.unique.name,
    email: Faker::Internet.free_email,
    password_digest: Faker::Internet.password(min_length: 8),
    key: Faker::Alphanumeric.alphanumeric(number: 10),
    user_type: 1,
    store: store
  )
end
