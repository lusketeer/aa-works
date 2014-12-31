# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  answer_choice_id :integer
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Response < ActiveRecord::Base
  validates :answer_choice_id, uniqueness: { scope: :user_id }
  validates :answer_choice_id, :user_id, presence: true
  validate :respondent_has_not_already_answered_question
  belongs_to(
    :answer_choice,
    class_name: 'AnswerChoice',
    foreign_key: :answer_choice_id,
    primary_key: :id
  )

  belongs_to(
    :respondent,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )

  has_one(
    :question,
    through: :answer_choice,
    source: :question
  )
  def sibling_responses
    Response
      .joins(:answer_choice)
      .joins("
        INNER JOIN
          (
            SELECT
              answer_choices.question_id
            FROM
              answer_choices
              INNER JOIN responses ON responses.answer_choice_id = answer_choices.id
            WHERE
              responses.answer_choice_id = #{self.answer_choice_id}
          ) s_t
          ON answer_choices.question_id = s_t.question_id
      ")
      .where("responses.id != ?", self.id)

    # self.id.nil? ? question.responses : question.responses.where("responses.id != ?", self.id)
    # Response.joins(question: :responses).where("responses.answer_choice_id = ?", self.answer_choice_id)
  end

  def respondent_has_not_already_answered_question
    # byebug
    sql =<<-SQL
      SELECT
        *
      FROM
        (
          SELECT
            answer_choices.question_id
          FROM
            answer_choices
          WHERE
            answer_choices.id = #{self.answer_choice_id}
        ) temp
      WHERE
        temp.question_id
        IN
        (
          SELECT
            answer_choices.question_id
          FROM
            answer_choices
            JOIN responses ON answer_choices.id = responses.answer_choice_id
          WHERE
            responses.user_id = #{self.user_id}
        )
    SQL
    count = ActiveRecord::Base.connection.execute(sql).count

    unless count == 0
      errors[:already_answered] << "you've already answered this question"
    end
  end

  def answering_own_question
    count = Poll
      .joins(questions: :answer_choices)
      .where("polls.author_id = ? AND answer_choices.id = ?", self.user_id, self.answer_choice_id)
      .count
    if count != 0
      errors[:answering_own] << "you can't answer your own poll"
    end
  end
end
