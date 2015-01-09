# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  validates :email, :password_digest, :session_token, presence: true
  validates :email, uniqueness: true
  after_initialize :ensure_session_token, :ensure_activation_token

  has_many :notes
  has_many :noted_tracks, through: :notes, source: :track


  def self.find_by_credentials(email, password)
      u = User.find_by(email: email)
      return nil if u.nil? || !u.is_password?(password)
      u
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def ensure_activation_token
    SecureRandom::urlsafe_base64(16)
    self.activation_token = SecureRandom::urlsafe_base64(16)
  end

  def activate!
    self.toggle!(:activated)
  end

  def ensure_session_token
    self.session_token = User.generate_session_token
  end

  def reset_session_token
    self.session_token = User.generate_session_token
    self.save
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

end
