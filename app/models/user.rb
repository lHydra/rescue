class User < ApplicationRecord
  has_secure_password
  has_many :posts

  validates_uniqueness_of :email
end
