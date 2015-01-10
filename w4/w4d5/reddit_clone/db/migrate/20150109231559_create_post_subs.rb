class CreatePostSubs < ActiveRecord::Migration
  def change
    create_table :post_subs do |t|
      t.references :sub, index: true, null: false
      t.references :post, index: true, null: false

      t.timestamps null: false
    end

    add_foreign_key :post_subs, :subs
    add_foreign_key :post_subs, :posts
  end
end
