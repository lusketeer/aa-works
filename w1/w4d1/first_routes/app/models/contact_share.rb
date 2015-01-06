class ContactShare < ActiveRecord::Base
  validates :user_id, :contact_id, presence: true
  validates :user_id, uniqueness: { scope: :contact_id }
  belongs_to :user
  belongs_to :contact
end
