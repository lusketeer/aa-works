class Group < ActiveRecord::Base
  validates :name, presence: true, uniqueness: { scope: :user_id }
  belongs_to :user

  has_many :groupings
  has_many :contacts, through: :groupings

end
