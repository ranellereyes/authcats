class Token < ActiveRecord::Base
  validates :user_id, :session_token, presence: true

  def self.generate_session_token
    SecureRandom::urlsafe_base64(32)
  end

  
end
