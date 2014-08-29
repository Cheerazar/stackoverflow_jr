class QuestionComment < ActiveRecord::Base
  validates :body, :user_id, :question_id, presence: true
  belongs_to :question
  belongs_to :user
end