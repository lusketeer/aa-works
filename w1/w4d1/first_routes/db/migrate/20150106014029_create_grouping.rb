class CreateGrouping < ActiveRecord::Migration
  def change
    create_table :groupings do |t|
      t.references :contact, index: true
      t.references :group, index: true
    end
    add_foreign_key :groupings, :contacts
    add_foreign_key :groupings, :groups
    add_index :groupings, [:contact_id, :group_id], unique: true
  end

end
