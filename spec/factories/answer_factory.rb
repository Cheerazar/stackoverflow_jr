FactoryGirl.define do
  factory :answer do
    body Faker::Lorem.paragraph
    user_id nil
    question_id nil
  end
end
