FactoryGirl.define do
  factory :answer_comment do
    body Faker::Lorem.paragraph
    user_id nil
    answer_id nil
  end
end
