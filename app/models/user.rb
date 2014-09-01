class User < ActiveRecord::Base

  validates :first_name, :last_name, :email, :username, presence: true
  validates :password_hash, length: { in: 6..60 }
  has_many :questions
  has_many :answers
  has_many :question_comments
  has_many :answer_comments
  has_many :question_votes
  has_many :answer_votes


end
