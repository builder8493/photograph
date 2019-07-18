class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :set_user

  def create
    current_user.follow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  private

    def set_user
      @user = User.find(params[:follow_id])
    end
end
