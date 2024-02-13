class EventInfosController < ApplicationController
  def new
    @event_info = EventInfo.new
    @group = Group.find(params[:id])
  end

  def create
    @event_info = EventInfo.new(event_info_params)
    @group_id = params[:event_info][:group_id]
    @title = params[:event_info][:title]
    @content = params[:event_info][:content]
    if @event_info.save
      EventMailer.send_mail(@title, @content, @group_id).deliver
    else
      render :new
    end
  end

  private

  def event_info_params
    params.require(:event_info).permit(:title, :content, :group_id)
  end
end
