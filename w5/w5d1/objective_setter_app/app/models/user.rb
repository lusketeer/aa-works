class User < ActiveRecord::Base
  include Commentable

  attr_reader :password
  validates :username, :session_token, :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true}

  has_many :goals
  has_many :authored_comments, class_name: "Comment", foreign_key: :user_id

  before_validation(on: :create) do
    self.session_token = SecureRandom::hex
  end

  def self.find_by_credentials(username, password)
    u = User.find_by(username: username)
    return nil if u.nil? || !u.is_password?(password)
    u
  end

  def password=(password)
    @password = password

    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = SecureRandom::hex
    self.save
    self.session_token
  end
end
