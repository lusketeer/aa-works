class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.references :user, index: true
      t.string :name, null: false

      t.timestamps null: false
    end
    add_foreign_key :groups, :users
    add_index :groups, [:user_id, :name], unique: true
  end
end
