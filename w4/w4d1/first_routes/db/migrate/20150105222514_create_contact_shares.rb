class CreateContactShares < ActiveRecord::Migration
  def change
    create_table :contact_shares do |t|
      t.references :user, index: true, null: false
      t.references :contact, index: true, null: false

      t.timestamps null: false
    end
    add_foreign_key :contact_shares, :users
    add_foreign_key :contact_shares, :contacts
    add_index :contact_shares, [:user_id, :contact_id], unique: true
  end
end
