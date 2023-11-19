class CreateApiKeys < ActiveRecord::Migration[7.0]
  def change
    create_table :api_keys do |t|
      t.references :user, null: false, foreign_key: true
      t.string :access_token
      t.datetime :expires_at

      t.timestamps

      t.index ["access_token"], unique: true
    end
  end
end
