class TopController < ApplicationController
  def home
    if logged_in?
      @posts = Post.page(params[:page]).per(6).search(params[:search])
      @comment = Comment.new
      @users = User.order("RANDOM()").limit(5)
    else
      @user = User.new
    end
  end
end
