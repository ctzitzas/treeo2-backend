# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


puts "creating store"
store = Store.create(
  name: "Corner Store Network",
  address: "42 Regent Street",
  suburb: "Oakleigh",
  state: "Victoria",
  postcode: "3250",
  key: "85e3b8c69cf6"
)

puts "creating admin account"
admin = User.create(
  name: "Admin",
  email: "admin@gmail.com",
  password_digest: BCrypt::Password.create("Password"),
  key: Faker::Alphanumeric.alphanumeric(number: 10),
  user_type: 2,
  store: store
)

puts 'creating existing user'
user = User.create(
  name: "Andrew Mahar",
  email: "andrew@test.com.au",
  password_digest: BCrypt::Password.create("Password"),
  key: "Andrew Mahar",
  user_type: 1,
  store: store
)

puts 'creating test user'
user = User.create(
  name: "Test user",
  email: "user@test.com",
  password_digest: BCrypt::Password.create("Password"),
  user_type: 1,
  store: store
)
