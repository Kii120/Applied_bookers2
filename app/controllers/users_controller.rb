class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @book = Book.new
  end
  
  def index
    @users = User.all
  end

  def edit
  end

  def update
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :profile_image)
  end

end
