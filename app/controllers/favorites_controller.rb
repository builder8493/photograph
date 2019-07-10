class FavoritesController < ApplicationController
  before_action :logged_in_user
  before_action :set_post

  def create
    current_user.like(@post)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_user.unlike(@post)
    redirect_back(fallback_location: root_path)
  end

  private
  
    def set_post
      @post = Post.find(params[:post_id])
    end
end
