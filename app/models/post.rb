class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :video_file

  validates :content, presence: true

  scope :search_by_keyword, -> (keyword) {
    unless keyword.blank?
      where('content LIKE ?', "%#{keyword}%")
    end
  }
end
