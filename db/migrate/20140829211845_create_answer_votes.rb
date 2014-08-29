class CreateAnswerVotes < ActiveRecord::Migration
  def change
    create_table :answer_votes do |t|
      t.boolean :upvote, default: false
      t.boolean :downvote, default: false
      t.integer :user_id
      t.integer :answer_id
      t.timestamps
    end
  end
end
