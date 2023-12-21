class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      flash[:notice] = "You have created the group successfully."
      redirect_to groups_path
    else
      render :new
    end
  end

  def index
    @groups = Group.all
    @book = Book.new
    @user = current_user
  end

  def show
    @group = Group.find(params[:id])
    @book = Book.new
    @user = current_user
  end

  def edit
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      flash[:notice] = "You have updated the group successfully."
      redirect_to groups_path
    else
      render :edit
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :group_image)
  end

end
