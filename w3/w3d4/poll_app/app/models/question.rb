# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  poll_id    :integer
#  text       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Question < ActiveRecord::Base
  validates :text, presence: true

  belongs_to(
    :poll,
    class_name: 'Poll',
    foreign_key: :poll_id,
    primary_key: :id
  )

  has_many(
    :answer_choices,
    class_name: 'AnswerChoice',
    foreign_key: :question_id,
    primary_key: :id,
    dependent: :destroy
  )

  has_many(
    :responses,
    through: :answer_choices,
    source: :responses
  )

  def results
    result_hash = {}
    self.answer_choices
      .select("answer_choices.*, COUNT(responses.id) as response_count")
      .joins("LEFT OUTER JOIN responses ON answer_choices.id = responses.answer_choice_id")
      .group("answer_choices.id")
      .order("answer_choices.id").each { |a| result_hash[a.text] = a.response_count }
    result_hash
  end
end
