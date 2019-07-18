class PostsController < ApplicationController
  before_action :logged_in_user, except: [:show, :hashtag]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def show
    @comment = Comment.new
    @comments = @post.comments
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "投稿しました"
      redirect_to root_url
    else
      flash.now[:danger] = "投稿に失敗しました"
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = "更新しました"
      redirect_to root_url
    else
      flash.now[:danger] = "更新に失敗しました"
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "削除しました"
    redirect_to root_path
  end

  def hashtag
    @tag = Hashtag.find_by(hashname: params[:id])
    @posts = @tag.posts.page(params[:page])
  end

  private

    def post_params
      params.require(:post).permit(:photo, :caption)
    end

    def set_post
      @post = Post.find(params[:id])
    end

    def correct_user
      redirect_to root_url unless @post.user == current_user
    end
end
