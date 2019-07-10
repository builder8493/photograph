class Comment < ApplicationRecord
  validates :content, presence: true, length: { maximum: 150 }
  validates :user_id, presence: true
  validates :post_id, presence: true
  belongs_to :post
  belongs_to :user
  default_scope -> {order(created_at: :desc)}
end
