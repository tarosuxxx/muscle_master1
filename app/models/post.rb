class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :video_file

  validates :content, presence: true
end
