class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :comments, dependent: :destroy
         
  validates :name, presence: true, length: { maximum: 50 }

  has_one_attached :profile_image
  has_one_attached :avatar

  def is_admin?
    is_admin 
  end
  
  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end
end