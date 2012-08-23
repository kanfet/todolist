class User < ActiveRecord::Base

  has_secure_password

  attr_accessible :username, :password, :password_confirmation

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  def self.authenticate(username, password)
    user = User.where(username: username).first
    if user && user.authenticate(password)
      user
    end
  end
end
