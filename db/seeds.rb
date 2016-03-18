# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Link.destroy_all

User.create(
  name: "Makinwa Bukola",
  email: "makinwa37@gmail.com",
  password: "makinwa37"
)

Link.create(
  user_id: User.first.id,
  given_url: "https://docs.google.com/document/d/1wVwa93VKX3XN9D-kwsf_aSNjWr2UTbfNn5YqBHuLpEU/edit",
  slug: "5yuvtc",
  clicks: 0,
  snapshot: nil,
  title: nil
)

puts "Seeding successful"
