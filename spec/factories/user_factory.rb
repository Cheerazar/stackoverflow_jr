FactoryGirl.define do
  factory :user do
    first_name Faker::Name.name.split(' ')[0]
    last_name Faker::Name.name.split(' ')[0]
    email Faker::Internet.email
    username Faker::Internet.user_name
    password_hash 'tested'
  end
end
