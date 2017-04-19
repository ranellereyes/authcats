class AddNullConstraintsToUserId < ActiveRecord::Migration
  def change
    change_column :cat_rental_requests, :user_id, :integer, null: false
    add_index :cat_rental_requests, :user_id
  end
end
