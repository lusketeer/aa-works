# == Schema Information
#
# Table name: notes
#
#  id         :integer          not null, primary key
#  track_note :text
#  user_id    :integer
#  track_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Note < ActiveRecord::Base
  belongs_to :author, class_name: "User", foreign_key: :user_id, primary_key: :id
  belongs_to :track

  validates :user_id, :track_id, :track_note, presence: true
end
