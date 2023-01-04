class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @book = Book.new
    # .post_imagesで特定のユーザの投稿すべてを持ってこれる
    # .allはユーザ関係なく全部
    @books = @user.books
  end

  def index
    @user = User.find(current_user.id)
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
