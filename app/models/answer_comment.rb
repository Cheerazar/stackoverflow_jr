class AnswerComment < ActiveRecord::Base
  validates :body, :user_id, :answer_id, presence: true
  belongs_to :user
  belongs_to :answer
end