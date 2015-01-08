class User < ActiveRecord::Base
  attr_reader :password
  has_many :cats
  has_many :cat_rental_requests
  has_many :cat_rentals, through: :cat_rental_requests, source: :cat
  has_many :session_tokens, class_name: "UserToken"

  validates :user_name, :password_digest, presence: true
  validates :password, length: { minimum: 8, allow_nil: true }
  # after_initialize :ensure_session_token




  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(@password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def create_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    UserToken.find_by(session_toke: session[:session_token]).destroy
    # self.session_tokens << SecureRandom::urlsafe_base64(16)
  end

  def self.find_by_credentials(user_name, password)
    @user = User.find_by(user_name: user_name)

    return nil if @user.nil?

    @user.is_password?(password) ? @user : nil
  end

end
