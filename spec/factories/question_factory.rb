FactoryGirl.define do
  factory :question do
    title Faker::Lorem.sentence
    body Faker::Lorem.paragraph
    user_id nil
  end
end
