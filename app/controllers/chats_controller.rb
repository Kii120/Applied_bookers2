class ChatsController < ApplicationController
  before_action :block_non_related_users, only: [:show]

  def show
    # 相手ユーザーを指定
    @opponent = User.find(params[:id])

    # current_userがもってるroomたちのid一覧を持ってくる
    rooms = current_user.user_rooms.pluck(:room_id) # pluckは()内のカラムだけ持ってくる

    # 相手とのuser_roomを特定
    user_room = UserRoom.find_by(user_id: @opponent.id, room_id: rooms) # room_idがroomsのうちのどれか

    if user_room.nil?
      @room = Room.new
      @room.save
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @opponent.id, room_id: @room.id)
    else
      @room = user_room.room
    end

    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end



  def create
    @chat = current_user.chats.new(chat_params)
    if @chat.save
      redirect_to request.referer
    else
      render 'validate'
    end
    # else
    #   render :show
    # end
  end


  def destroy
    @chat = Chat.find(params[:id])
    if @chat.user_id == current_user.id
      @chat.destroy

    end
    redirect_to request.referer
  end

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

  def block_non_related_users
    opponent = User.find(params[:id])
    unless current_user.following?(opponent) && opponent.following?(current_user)
      redirect_to books_path
    end
  end

end
