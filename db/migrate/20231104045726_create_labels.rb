class CreateLabels < ActiveRecord::Migration[7.0]
  def change
    create_table :labels do |t|
      t.integer :number, null: false
      t.string :title, null: false

      t.timestamps
    end
  end
end
