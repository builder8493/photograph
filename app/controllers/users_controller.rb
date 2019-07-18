class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, except: [:show, :new, :create]

  def show
    @posts = @user.posts
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "ユーザーを登録しました"
      redirect_to root_url
    else
      flash.now[:danger] = "ユーザーの登録に失敗しました"
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "ユーザーを更新しました"
      redirect_to @user
    else
      flash.now[:danger] = "ユーザーの更新に失敗しました"
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to root_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :user_name, :profile, :user_image, :email, :password)
    end

    def set_user
      @user = User.find(params[:id])
    end
end
