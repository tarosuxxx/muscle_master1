# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# db/seeds.rb

parts_list = ["胸", "肩", "背中", "腕", "足", "腹筋"]

parts_list.each do |name|
  Part.find_or_create_by!(name: name) do |part|
    # 他に必要な属性があれば設定できますが、今回は name のみで十分です
  end
end

puts "Parts (#{Part.count}) seeded successfully!"