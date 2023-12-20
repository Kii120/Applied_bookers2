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
    user_id = params[:id].to_i
    unless user_id == current_user.id
      redirect_to user_path(current_user.id)
    end
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def search
    @date = params[:date]
    @user = User.find(params[:user_id])
    @bookscount = @user.books.where(['created_at LIKE ? ', "#{@date}%"]).count
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
