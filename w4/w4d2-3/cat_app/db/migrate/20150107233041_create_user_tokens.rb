class CreateUserTokens < ActiveRecord::Migration
  def change
    create_table :user_tokens do |t|
      t.references :user, index: true, null: false
      t.string :session_token, index: true, null: false
      t.string :device_info
      t.string :ip_address

      t.timestamps null: false
    end
    add_foreign_key :user_tokens, :users
  end
end
