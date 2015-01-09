# == Schema Information
#
# Table name: bands
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Band < ActiveRecord::Base
  has_many :albums
  has_many :tracks, through: :albums
  validates :name, presence: true
end
