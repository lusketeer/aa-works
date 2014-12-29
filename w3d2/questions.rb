require 'sqlite3'
require 'singleton'
require 'active_support/inflector'


class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')

    self.results_as_hash = true
    self.type_translation = true
  end

end

class BackBone


  def self.underscore
    word = self.to_s
    word.gsub!(/::/, '/')
    word.gsub!(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
    word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
    word.tr!("-", "_")
    word.downcase!
    word.pluralize
  end

  def self.all
    query = <<-SQL
      SELECT
        *
      FROM
        #{self.underscore}
    SQL

    results = QuestionsDatabase.instance.execute(query)
    results.map { |result| self.new(result) }
  end

  def self.find_by_id(id)
    query = <<-SQL
      SELECT
        *
      FROM
        #{self.underscore}
      WHERE
        id = ?
    SQL

    results = QuestionsDatabase.instance.execute(query, id)
    results.map { |result| self.new(result) }.first
  end

  def save
    if id.nil?
      create
    else
      update
    end
    self
  end

  def var_syms
    self.instance_variables.map do |var|
      var.to_s.gsub("@", "").to_sym
    end.reject { |var| var == :id }
  end

  def get_instance_variable_values
    var_syms.map { |param| self.send(param)}
  end

  def sql_format
    var_syms.map { |param| "?"}.join(", ")
  end

  def create
    question_marks = sql_format

    query = <<-SQL
      INSERT INTO
        #{self.class.underscore} (#{var_syms.map(&:to_s).join(", ")})
      VALUES
        (#{question_marks})
    SQL
    QuestionsDatabase.instance.execute(query, *get_instance_variable_values)

    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update_vals
    var_syms.map { |param| "#{param.to_s} = '#{self.send(param)}'"}
  end

  def update
    query = <<-SQL
      UPDATE
        #{self.class.underscore}
      SET
        #{update_vals.join(", ")}
      WHERE
        id = ?
    SQL

    QuestionsDatabase.instance.execute(query, self.id)
  end
end

class User < BackBone
  attr_accessor :fname, :lname
  attr_reader :id

  def self.find_by_name(fname, lname)
    query = <<-SQL
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?
    SQL

    results = QuestionsDatabase.instance.execute(query, fname, lname)
    results.map { |result| self.new(result) }
  end

  def initialize(params)
    @id    = params['id']
    @fname = params['fname']
    @lname = params['lname']
  end

  def authored_questions
    Question.find_by_author_id(self.id)
  end

  def authored_replies
    Reply.find_by_user_id(self.id)
  end

  def followed_questions
    QuestionFollower.followed_questions_for_user_id(self.id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(self.id)
  end

  def average_karma
    query = <<-SQL
      SELECT
        CAST(count(question_id) as FLOAT) / count(distinct question_id)  as avg_karma
      FROM
        question_likes
      WHERE
        question_id IN
        (
          SELECT
            id
          FROM
            questions
          WHERE
            author_id = ?
        )

    SQL

    results = QuestionsDatabase.instance.execute(query, self.id)
    results.first['avg_karma']
  end

end

class Question < BackBone
  attr_accessor :title, :body, :author_id
  attr_reader :id

  def self.find_by_author_id(author_id)
    query = <<-SQL
      SELECT
        *
      FROM
        questions
      WHERE
        author_id = ?
    SQL

    results = QuestionsDatabase.instance.execute(query, author_id)
    results.map { |result| self.new(result) }
  end

  def self.most_followed(n)
    QuestionFollower.most_followed_questions(n)
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  def initialize(params)
    @id    = params['id']
    @title = params['title']
    @body = params['body']
    @author_id = params['author_id']
  end

  def author
    query = <<-SQL
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL

    results = QuestionsDatabase.instance.execute(query, self.author_id)
    results.map { |result| User.new(result) }
  end

  def replies
    Reply.find_by_question_id(self.id)
  end

  def followers
    QuestionFollower.followers_for_question_id(self.id)
  end

  def likers
    QuestionLike.likers_for_question_id(self.id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(self.id)
  end

end


class Reply < BackBone
  attr_accessor :body
  attr_reader :id, :question_id, :parent_reply_id, :user_id

  def self.find_by_question_id(question_id)
    query = <<-SQL
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?
    SQL

    results = QuestionsDatabase.instance.execute(query, question_id)
    results.map { |result| Reply.new(result) }
  end

  def self.find_by_user_id(user_id)
    query = <<-SQL
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = ?
    SQL

    results = QuestionsDatabase.instance.execute(query, user_id)
    results.map { |result| Reply.new(result) }
  end

  def initialize(params)
    @id              = params['id']
    @question_id     = params['question_id']
    @parent_reply_id = params['parent_reply_id']
    @body            = params['body']
    @user_id         = params['user_id']
  end

  def author
    query = <<-SQL
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL

    results = QuestionsDatabase.instance.execute(query, self.user_id)
    results.map { |result| User.new(result) }
  end

  def question
    query = <<-SQL
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?
    SQL

    results = QuestionsDatabase.instance.execute(query, self.question_id)
    results.map { |result| Question.new(result) }
  end

  def parent_reply
    query = <<-SQL
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL

    results = QuestionsDatabase.instance.execute(query, self.parent_reply_id)
    results.map { |result| Reply.new(result) }
  end

  def child_replies
    query = <<-SQL
      SELECT
        *
      FROM
        replies
      WHERE
        parent_reply_id = ?
    SQL

    results = QuestionsDatabase.instance.execute(query, self.id)
    results.map { |result| Reply.new(result) }
  end

end

class QuestionFollower < BackBone
  attr_reader :question_id, :follower_id

  def self.most_followed_questions(n)
    query = <<-SQL
      SELECT
        *
      FROM
        questions
      WHERE
        id IN
        (
          SELECT
            question_id
          FROM
            question_followers
          GROUP BY
            question_id
          ORDER BY
            COUNT(question_id) DESC
          LIMIT
            ?
        )
    SQL

    results = QuestionsDatabase.instance.execute(query, n)
    results.map { |result| Question.new(result) }
  end
  def self.followers_for_question_id(question_id)
    query = <<-SQL
      SELECT
        u.*
      FROM
        question_followers qf
        JOIN
          users u
          ON
          u.id = qf.follower_id
      WHERE
        qf.question_id = ?
    SQL

    results = QuestionsDatabase.instance.execute(query, question_id)
    results.map { |result| User.new(result) }
  end

  def self.followed_questions_for_user_id(user_id)
    query = <<-SQL
      SELECT
        q.*
      FROM
        question_followers qf
        JOIN
          questions q
          ON
          q.id = qf.question_id
      WHERE
        qf.follower_id = ?
    SQL

    results = QuestionsDatabase.instance.execute(query, user_id)
    results.map { |result| Question.new(result) }
  end

  def initialize(params)
    @question_id = params['question_id']
    @follower_id = params['follower_id']
  end

  def self.find_by_id(id)
    nil
  end
end

class QuestionLike < BackBone
  attr_reader :question_id, :user_id

  def self.most_liked_questions(n)
    query = <<-SQL
      SELECT
        *
      FROM
        questions
      WHERE
        id IN
          (
            SELECT
              question_id
            FROM
              question_likes
            GROUP BY
              question_id
            ORDER BY
              COUNT(question_id) DESC
            LIMIT
              ?
          )
    SQL

    results = QuestionsDatabase.instance.execute(query, n)
    results.map { |result| Question.new(result) }
  end

  def self.likers_for_question_id(question_id)
    query = <<-SQL
      SELECT
        *
      FROM
        users
      WHERE
        id IN (
          SELECT
            user_id
          FROM
            question_likes
          WHERE
            question_id = ?
        )
    SQL

    results = QuestionsDatabase.instance.execute(query, question_id)
    results.map { |result| User.new(result) }
  end

  def self.num_likes_for_question_id(question_id)
    query = <<-SQL
      SELECT
        COUNT(user_id) AS num_of_likes
      FROM
        question_likes
      WHERE
        question_id = ?
    SQL

    results = QuestionsDatabase.instance.execute(query, question_id)
    results.first['num_of_likes']
  end

  def self.liked_questions_for_user_id(user_id)
    query = <<-SQL
      SELECT
        *
      FROM
        questions
      WHERE
        id IN (
          SELECT
            question_id
          FROM
            question_likes
          WHERE
            user_id = ?
        )
    SQL

    results = QuestionsDatabase.instance.execute(query, user_id)
    results.map { |result| Question.new(result) }
  end

  def initialize(params)
    @question_id = params['question_id']
    @follower_id = params['user_id']
  end

  def self.find_by_id(id)
    nil
  end
end
