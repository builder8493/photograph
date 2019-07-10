class Post < ApplicationRecord
  validates :caption, length: { maximum: 150 }
  validates :photo, presence: true
  validates :user_id, presence: true
  mount_uploader :photo, PhotosUploader
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
  has_and_belongs_to_many :hashtags
  default_scope -> {order(created_at: :desc)}

  after_create do
    post = Post.find_by(id: self.id)
    hashtags = self.caption.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#').delete("＃"))
      self.hashtags << tag
    end
  end

  before_update do
    post = Post.find_by(id: self.id)
    post.hashtags.clear
    hashtags = self.caption.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#').delete("＃"))
      self.hashtags << tag
    end
  end

  def self.search(search)
    return Post.all unless search
    Post.where(['caption LIKE ?', "%#{search}%"])
  end
end