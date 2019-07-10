class User < ApplicationRecord
  before_save :downcase_email
  validates :name, length: { maximum: 30 }
  VALID_USER_NAME = /[\w\._]+/
  validates :user_name, uniqueness: true, length: { maximum: 30 },
                        format: { with: VALID_USER_NAME }
  validates :profile, length: { maximum: 150 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitve: false}
  has_secure_password
  mount_uploader :user_image, UserImagesUploader
  has_many :posts, dependent: :destroy
  has_many :relationships, dependent: :destroy
  has_many :reverce_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
  has_many :following, through: :relationships, source: :follow
  has_many :follower, through: :reverce_of_relationships, source: :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :fav_posts, through: :favorites, source: :post

  def follow(user)
    following << user
  end

  def unfollow(user)
    relationships.find_by(follow_id: user.id).destroy
  end

  def following?(user)
    self.following.include?(user)
  end

  def like(post)
    fav_posts << post
  end

  def unlike(post)
    favorites.find_by(post_id: post.id).destroy
  end

  def like?(post)
    fav_posts.include?(post)
  end

  private
  
    def downcase_email
      email.downcase!
    end
end
