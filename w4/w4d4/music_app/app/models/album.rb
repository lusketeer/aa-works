# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  band_id    :integer
#  name       :string
#  album_type :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Album < ActiveRecord::Base
  belongs_to :band
  has_many :tracks
  delegate :name,
            to: :band,
            prefix: true

  ALBUM_TYPE = ["Live", "Studio"]

  validates :name, :band_id, :album_type, presence: true
  validates :album_type, inclusion: { in: ALBUM_TYPE }
end
