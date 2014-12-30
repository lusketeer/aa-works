# == Schema Information
#
# Table name: taggings
#
#  id         :integer          not null, primary key
#  tag_id     :integer
#  url_id     :integer
#  created_at :datetime
#  updated_at :datetime
#

class Tagging < ActiveRecord::Base

  belongs_to(
    :tag_topic,
    class_name: 'TagTopic',
    foreign_key: :tag_id,
    primary_key: :id
  )

  belongs_to(
    :url,
    class_name: 'ShortenedUrl',
    foreign_key: :url_id,
    primary_key: :id
  )

  def self.create_tagging_with_url_and_tag(url, tag)
    Tagging.create!(tag_id: tag.id, url_id: url.id)
  end

end
