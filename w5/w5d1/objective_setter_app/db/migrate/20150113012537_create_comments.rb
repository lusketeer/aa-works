class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :user_id
      t.references :commentable, index: true, polymorphic: true

      t.timestamps null: false
    end
    add_foreign_key :comments, :commentables
    add_foreign_key :comments, :user_id
  end
end
