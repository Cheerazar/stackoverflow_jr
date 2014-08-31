FactoryGirl.define do
  factory :question_comment do
    body Faker::Lorem.paragraph
    user_id nil
    question_id nil
  end
end
