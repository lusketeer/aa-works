# == Schema Information
#
# Table name: shortened_urls
#
#  id           :integer          not null, primary key
#  submitter_id :integer
#  short_url    :string
#  long_url     :string
#  created_at   :datetime
#  updated_at   :datetime
#

class ShortenedUrl < ActiveRecord::Base
  has_many(
    :visits,
    class_name: 'Visit',
    foreign_key: :url_id,
    primary_key: :id
  )

  has_many(
    :visitors,
    -> { distinct },
    through: :visits,
    source: :user
  )

  belongs_to(
    :submitter,
    class_name: 'User',
    foreign_key: :submitter_id,
    primary_key: :id
  )

  has_many(
    :taggings,
    class_name: 'Tagging',
    foreign_key: :url_id,
    primary_key: :id
  )

  has_many(
    :tag_topics,
    through: :taggings,
    source: :tag_topic
  )

  validates :submitter_id, :long_url, presence: true

  def self.random_code
    url = SecureRandom::urlsafe_base64
    if ShortenedUrl.exists?(short_url: url)
      ShortenedUrl.random_code
    else
      url
    end
  end

  def self.create_for_user_and_long_url!(user, long_url)
    url = ShortenedUrl.new(
      long_url: long_url,
      submitter_id: user.id,
      short_url: ShortenedUrl.random_code
    )
    url.save!
    url
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    visits("updated_at > ?", 10.minutes.ago).select(:visitor_id).distinct(:visitor_id).count
  end

end
