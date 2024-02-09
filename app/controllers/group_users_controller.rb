class GroupUsersController < ApplicationController
  def create
    @group = Group.find(params[:group_id])
    @group_user = GroupUser.new
    @group_user.user_id = current_user.id
    @group_user.group_id = @group.id
    if @group_user.save
      redirect_to controller: :groups, action: :index
    else
      render :back
    end
  end

  def destroy
    group = Group.find(params[:id])
    group_user = GroupUser.find_by(user_id: current_user, group_id: group.id)
    group_user.destroy
    redirect_to controller: :groups, action: :index
  end
end
