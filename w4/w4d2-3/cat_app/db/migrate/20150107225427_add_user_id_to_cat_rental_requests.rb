class AddUserIdToCatRentalRequests < ActiveRecord::Migration
  def change
    add_column :cat_rental_requests, :renter_id, :integer, index: true
  end
end
