class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.references :album, index: true
      t.string :name
      t.string :track_type
      t.text :lyrics

      t.timestamps null: false
    end
    add_foreign_key :tracks, :albums
  end
end
