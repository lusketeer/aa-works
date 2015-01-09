# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  album_id   :integer
#  name       :string
#  track_type :string
#  lyrics     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Track < ActiveRecord::Base
  belongs_to :album
  has_one :band, through: :album, source: :band
  has_many :notes

  delegate :name, :album_type, :band_name,
            to: :album,
            prefix: true

  TRACK_TYPE = ["Bonus", "Regular"]
  validates :album_id, :name, :track_type, presence: true
  validates :track_type, inclusion: { in: TRACK_TYPE }
end
