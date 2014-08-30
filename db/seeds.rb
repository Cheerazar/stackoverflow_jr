# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user_ids = 20
question_ids = 200
question_comment_ids = 200
answer_ids = 200
answer_comment_ids = 200

user_ids.times do
  fake_first_name, fake_last_name = Faker::Name.name.split(' ')
  User.create(  first_name: fake_first_name,
                last_name: fake_last_name,
                email: Faker::Internet.email,
                username: Faker::Internet.user_name,
                password_hash: 'tested'
                )
end
