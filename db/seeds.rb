# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Chef.destroy_all
Recipe.destroy_all
10.times{
    Chef.create!(
         name: Faker::Name.name ,
         email: Faker::Internet.email,
         password: "asdf1234",
         password_confirmation: "asdf1234"
         )
}


Chef.all.each do |c|
  3.times {Recipe.create!(
                  name: Faker::Commerce.product_name,
                  summary: Faker::Lorem.sentences(1),
                  description: Faker::Lorem.paragraph ,
                  picture: Faker::Avatar.image,
                  chef_id: c.id
                 )}
end