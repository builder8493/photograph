class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :set_user

  def create
    current_user.follow(@user)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_user.unfollow(@user)
    redirect_back(fallback_location: root_path)
  end

  private

    def set_user
      @user = User.find(params[:follow_id])
    end
end
