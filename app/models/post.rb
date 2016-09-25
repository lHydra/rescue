class Post < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :text, presence: true
  validates :author, presence: true

  mount_uploader :thumb, ThumbUploader
end
