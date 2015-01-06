class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.references :user, index: true
    end
    add_foreign_key :contacts, :users
    add_index :contacts, [:email, :user_id], unique: true
  end
end
