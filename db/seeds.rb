# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Flat.destroy_all


flat  = Flat.create(address: "Kraków, Jana Kasprowicza 16", number_of_rooms: 3, area: 74)

puts "FLATS_CREATED"