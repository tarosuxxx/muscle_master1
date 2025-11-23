class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :video_file
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user

  validates :content, presence: true
end
