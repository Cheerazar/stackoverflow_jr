class User < ActiveRecord::Base
  validates :first_name, :last_name, :email, :username, presence: true
  has_many :questions
  has_many :answers
  has_many :question_comments
  has_many :answer_comments
  has_many :question_votes
  has_many :answer_votes
end