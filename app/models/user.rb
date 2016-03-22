class User < ActiveRecord::Base
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: EMAIL_REGEX}
  validates :name, :password, presence: true
  has_secure_password
end
