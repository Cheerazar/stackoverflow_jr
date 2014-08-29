class CreateAnswerComments < ActiveRecord::Migration
  def change
    create_table :answer_comments do |t|
      t.text :body
      t.integer :user_id
      t.integer :answer_id
      t.timestamps
    end
  end
end
