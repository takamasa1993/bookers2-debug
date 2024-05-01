class RelationshipsController < ApplicationController

  def show
    @user = User.find(params[:id])
    @followers_count = @user.followers.count
    @following_count = @user.following.count
  end

  def index
  end

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.followings << @user
    redirect_to request.referer
  end

  def destroy
    @relationship = Relationship.find(params[:id])
    @relationship.destroy
    redirect_to request.referer
  end

  def followings
    user = User.find(params[:id])
		@users = user.followings
  end

  def followers
    user = User.find(params[:id])
		@users = user.followers
  end
end
