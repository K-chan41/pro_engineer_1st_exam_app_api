class CreateSubjects < ActiveRecord::Migration[7.0]
  def change
    create_table :subjects do |t|
      t.integer :year,              null: false
      t.integer :exam_subject,      null: false, default: 0

      t.timestamps
    end
  end
end
