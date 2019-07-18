class FavoritesController < ApplicationController
  before_action :logged_in_user
  before_action :set_post

  def create
    current_user.like(@post)
    respond_to do |format|
      format.html { redirect_to @post }
      format.js
    end
  end

  def destroy
    current_user.unlike(@post)
    respond_to do |format|
      format.html { redirect_to @post }
      format.js
    end
  end

  private
  
    def set_post
      @post = Post.find(params[:post_id])
    end
end
