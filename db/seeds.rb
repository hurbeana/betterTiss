# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name: 'Alexander Hurbean',
             email: 'hurbeana@gmail.com',
             password: 'foobar',
             password_confirmation: 'foobar',
             admin: true)
User.create!(name: 'Bernhard Ploder',
             email: 'bernhard1996@gmail.com',
             password: 'foobar',
             password_confirmation: 'foobar',
             admin: true)
User.create!(name: 'Silvana Grausgruber',
             email: '1996silvana1996@gmx.at',
             password: 'foobar',
             password_confirmation: 'foobar',
             admin: true)

15.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = 'password'
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end