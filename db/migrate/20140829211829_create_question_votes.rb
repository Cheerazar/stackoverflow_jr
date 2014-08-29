class CreateQuestionVotes < ActiveRecord::Migration
  def change
    create_table :question_votes do |t|
      t.boolean :upvote, default: false
      t.boolean :downvote, default: false
      t.integer :user_id
      t.integer :question_id
      t.timestamps
    end
  end
end
