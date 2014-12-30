class CreateTagging < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :tag_id
      t.integer :url_id

      t.timestamps
    end

    add_index :taggings, :tag_id
  end
end
