class User < ApplicationRecord
  has_secure_password
  has_many :posts
  class << self
    def from_omniauth(auth_hash)
      user = find_or_create_by(uid: auth_hash[:uid], provider: auth_hash[:provider])
      user.name = auth_hash[:info][:name]
      user.save!
      user
    end
  end
  validates_uniqueness_of :email
end
