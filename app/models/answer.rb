class Answer < ActiveRecord::Base
  validates :body, :user_id, presence: true
  belongs_to :question
  belongs_to :user
  has_many :answer_comments
  has_many :answer_votes
end