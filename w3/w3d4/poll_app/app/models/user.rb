# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  user_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  validates :user_name, uniqueness: true, presence: true

  has_many(
    :authored_polls,
    class_name: "Poll",
    foreign_key: :author_id,
    primary_key: :id
  )

  has_many(
    :responses,
    class_name: 'Response',
    foreign_key: :user_id,
    primary_key: :id
  )

  def fully_joined_table
    Poll.select("polls.*, COUNT(questions.id) as question_count")
    .joins(:questions)
    .joins(
    "LEFT OUTER JOIN
      (
        SELECT
          responses.*, answer_choices.question_id
        FROM
          responses
        JOIN
          answer_choices ON responses.answer_choice_id = answer_choices.id
        WHERE
          responses.user_id = #{self.id}
       ) r
      ON questions.id = r.question_id")
      .group("polls.id")
  end

  def incompleted_polls
    fully_joined_table.having("COUNT(r.id) != COUNT(questions.id)")
  end

  def completed_polls
    fully_joined_table.having("COUNT(r.id) = COUNT(questions.id)")
  end
end
