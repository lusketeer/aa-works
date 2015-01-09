class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :track_note
      t.references :user, index: true
      t.references :track, index: true

      t.timestamps null: false
    end
    add_foreign_key :notes, :users
    add_foreign_key :notes, :tracks
    add_index :notes, [:user_id, :track_id]
  end
end
