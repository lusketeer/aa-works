class Contact < ActiveRecord::Base
  validates :email, :name, presence: true
  validates :user_id, uniqueness: { scope: :email }

  has_many :groupings
  has_many :groups, through: :groupings
  has_many :comments, as: :commentable
  belongs_to(
    :owner,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )
  has_many(
    :contact_shares,
    class_name: "ContactShare",
    foreign_key: :contact_id,
    primary_key: :id,
    dependent: :destroy
  )
  has_many(
    :shared_users,
    through: :contact_shares,
    source: :user
  )
end
