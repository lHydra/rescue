class Post < ApplicationRecord
  include PgSearch
  pg_search_scope :search_by_title_or_text, against: [:title, :text]

  belongs_to :user

  validates :title, presence: true
  validates :text, presence: true
  validates :author, presence: true

  mount_uploader :thumb, ThumbUploader
end
