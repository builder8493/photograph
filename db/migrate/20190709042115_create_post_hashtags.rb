class CreatePostHashtags < ActiveRecord::Migration[5.2]
  def change
    create_table :hashtags_posts, id: false do |t|
      t.references :post, foreign_key: true
      t.references :hashtag, foreign_key: true
    end
  end
end
