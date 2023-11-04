class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.references :subject, null: false, foreign_key: true
      t.references :label, foreign_key: true
      t.integer :number, null: false
      t.text :content, null: false
      t.string :question_img_src
      t.integer :correct_answer_no, null: false
      t.text :commentary, null: false
      t.string :answer_img_src

      t.timestamps
    end
  end
end
