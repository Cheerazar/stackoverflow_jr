class Question < ActiveRecord::Base
  validate :title, :body, :user_id, presence: true
  belongs_to :user
  has_many :answers
  has_many :question_comments
  has_many :question_votes
end