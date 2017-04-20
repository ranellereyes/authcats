class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.integer :user_id, null: false
      t.string :session_token, null: false

      t.index :user_id
      t.index :session_token

      t.timestamps null: false
    end
  end
end
