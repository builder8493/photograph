class Micropost < ApplicationRecord
  belongs_to :post
  belongs_to :hashtag
  validates :micropost_id, presence: true
  validates :hashtag,      presence: true
end