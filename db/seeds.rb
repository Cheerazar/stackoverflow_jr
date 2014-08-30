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

question_ids.times do
  Question.create(  title: Faker::Lorem.sentence,
                    body: Faker::Lorem.paragraph,
                    user_id: rand(1..user_ids)
    )
end

question_comment_ids.times do
  QuestionComment.create( body: Faker::Lorem.paragraph,
                          user_id: rand(1..user_ids),
                          question_id: rand(1..question_ids)
    )
end

answer_ids.times do
  Answer.create(  body: Faker::Lorem.paragraph,
                  user_id: rand(1..user_ids),
                  question_id: rand(1..question_ids)
    )
end

answer_comment_ids.times do
  AnswerComment.create( body: Faker::Lorem.paragraph,
                        user_id: rand(1..user_ids),
                        answer_id: rand(1..answer_ids)
    )
end
