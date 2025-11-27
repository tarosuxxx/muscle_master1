class Post < ApplicationRecord
  belongs_to :user

  has_one_attached :video
  
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy
  has_many :post_parts, dependent: :destroy
  has_many :parts, through: :post_parts

  validates :content, presence: true

  scope :search_by_keyword, -> (keyword) {
    unless keyword.blank?
      where('content LIKE ?', "%#{keyword}%")
    end
  }
end
