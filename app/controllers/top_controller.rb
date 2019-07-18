class TopController < ApplicationController
  def home
    @posts = Post.page(params[:page]).per(6).search(params[:search])
    @comment = Comment.new
    @users = User.order("RANDOM()").limit(5)
  end
end
