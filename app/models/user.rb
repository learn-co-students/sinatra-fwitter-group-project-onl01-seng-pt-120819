class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  validates :username, presence: true, uniqueness: true 
  validates :email, presence: true, uniqueness: true 
  validates :password, presence: true
end
