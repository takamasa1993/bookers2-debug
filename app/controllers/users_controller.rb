class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @followings_count = @user.followings_count
    @followers_count = @user.followers_count
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
    @following_count = current_user.followings_count
    @followers_count = current_user.followers_count
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render :edit
    end
  end
  
  def follow
    @user = User.find(params[:id])
    current_user.follow(@user)
    redirect_to @user
  end

  def unfollow
    @user = User.find(params[:id])
    current_user.unfollow(@user)
    redirect_to @user
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def is_matching_login_user
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end

end
