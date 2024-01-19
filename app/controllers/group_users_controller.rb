class GroupUsersController < ApplicationController
  def creat
    @group_user = GroupUser.new
    @group_user.user_id = current_user.id
    @group_user.group_id = @group.id
    if @group_user.save
      redirect_to contoroller: :Group, action: :index
    else
      render :back
    end
  end

  def destroy
    group_user = GroupUser.find_by(user_id: current_user, group_id: group.id)
    group_user.destroy
    redirect_to contoroller: :Group, action: :index
  end
end
