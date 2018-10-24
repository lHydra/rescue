class Post < ApplicationRecord
  include PgSearch
  pg_search_scope :search_by_title_or_text, against: [:title, :text]

  belongs_to :user
  has_many :taggings
  has_many :tags, through: :taggings

  validates :title, presence: true
  validates :text, presence: true
  validates :author, presence: true

  mount_uploader :thumb, ThumbUploader

  def all_tags=(names)
    self.tags = names.split(',').map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:name).join(', ')
  end
end
