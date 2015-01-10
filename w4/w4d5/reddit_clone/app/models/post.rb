# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  belongs_to :author, class_name: "User"
  has_many :post_subs
  has_many :subs, through: :post_subs
  has_many :comments, as: :commentable

  validates :author_id, :title, presence: true
end
