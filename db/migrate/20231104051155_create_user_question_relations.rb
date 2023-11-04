class CreateUserQuestionRelations < ActiveRecord::Migration[7.0]
  def change
    create_table :user_question_relations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.integer :answer, null: false

      t.timestamps
    end
  end
end
