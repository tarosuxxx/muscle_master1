class Part < ApplicationRecord
  has_many :post_parts, dependent: :destroy
  has_many :posts, through: :post_parts
end