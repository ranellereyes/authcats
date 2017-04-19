class User < ActiveRecord::Base
  validates :username, :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :session_token, presence: true, uniqueness: true

  after_initialize :reset_session_token!

  attr_reader :password

  has_many :cats,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: 'Cat'

  has_many :requests,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: 'CatRentalRequest'

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return user if user && user.is_password?(password)
    nil
  end

  def reset_session_token!
    self.session_token ||= self.class.generate_session_token
    # self.save!
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(32)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

end
