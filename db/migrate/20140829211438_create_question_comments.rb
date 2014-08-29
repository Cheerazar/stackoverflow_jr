class CreateQuestionComments < ActiveRecord::Migration
  def change
    create_table :question_comments do |t|
      t.text :body
      t.integer :user_id
      t.integer :question_id
    end
  end
end
