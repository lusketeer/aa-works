# == Schema Information
#
# Table name: post_subs
#
#  id         :integer          not null, primary key
#  sub_id     :integer          not null
#  post_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PostSub < ActiveRecord::Base
  belongs_to :sub, inverse_of: :post_subs
  belongs_to :post, inverse_of: :post_subs

  validates :sub, :post, presence: true
end
