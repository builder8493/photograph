class CommentsController < ApplicationController
  before_action :logged_in_user

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(comment_params)
    @comment.post_id = @post.id
    if @comment.save
      redirect_back(fallback_location: root_path)
    else
      @posts = Post.all
      render 'top/home'
    end
  end

  def destroy
    current_user.comments.find(params[:id]).destroy
    redirect_back(fallback_location: root_path)
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end
end
