class ChatRoomsController < ApplicationController
  before_action :set_chat_room, only: [:show, :update, :destroy]

  # GET /chat_rooms
  def index
    current_user = User.find_by_token(params[:token])
    @chat_rooms = ChatRoom.joins(:chat_room_members).where(chat_room_members: {user: current_user})

    render json: @chat_rooms
  end

  # GET /chat_rooms/1
  def show
    render json: @chat_room
  end

  # POST /chat_rooms
  def create
    chat_room_params
    current_user = User.find_by_token(params[:token])
    @chat_room = ChatRoom.new(
       user_id: current_user.id,
       name: params[:name]
    )

    if @chat_room.save
      ChatRoomMember.new(
          user_id: current_user.id,
          chat_room_id: @chat_room.id
      ).save
      ChatRoomMember.new(
          user_id: params[:user_id],
          chat_room_id: @chat_room.id
      ).save

      render json: @chat_room, status: :created, location: @chat_room
    else
      render json: @chat_room.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /chat_rooms/1
  def update
    if @chat_room.update(chat_room_params)
      render json: @chat_room
    else
      render json: @chat_room.errors, status: :unprocessable_entity
    end
  end

  # DELETE /chat_rooms/1
  def destroy
    @chat_room.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat_room
      @chat_room = ChatRoom.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def chat_room_params
      params.require(:chat_room).permit(:user_id, :name)
    end
end
