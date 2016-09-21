class User < ApplicationRecord
  has_secure_password
  has_many :post

  validates_uniqueness_of :email
end
