class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true
  has_many :comments, as: :commentable
  has_many :groups

  has_many(
    :contacts,
    class_name: "Contact",
    foreign_key: :user_id,
    primary_key: :id
  )
  has_many(
    :contact_shares,
    class_name: "ContactShare",
    foreign_key: :user_id,
    primary_key: :id
  )
  has_many(
    :shared_contacts,
    through: :contact_shares,
    source: :contact
  )

  def all_contacts
    # contacts + shared_contacts
    Contact.where(
      "contacts.id IN
      (
        SELECT contacts.id FROM contacts WHERE contacts.user_id = #{self.id}
      )
      OR contacts.id IN
      (
        SELECT contact_shares.contact_id FROM contact_shares WHERE contact_shares.user_id = #{self.id}
      )
      "
    )

  end

end
