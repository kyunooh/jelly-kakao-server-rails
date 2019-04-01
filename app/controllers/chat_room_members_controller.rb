class ChatRoomMembersController < ApplicationController
  before_action :set_chat_room_member, only: [:show, :update, :destroy]

  # GET /chat_room_members
  def index
    @chat_room_members = ChatRoomMember.all

    render json: @chat_room_members
  end

  # GET /chat_room_members/1
  def show
    render json: @chat_room_member
  end

  # POST /chat_room_members
  def create
    @chat_room_member = ChatRoomMember.new(chat_room_member_params)

    if @chat_room_member.save
      render json: @chat_room_member, status: :created, location: @chat_room_member
    else
      render json: @chat_room_member.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /chat_room_members/1
  def update
    if @chat_room_member.update(chat_room_member_params)
      render json: @chat_room_member
    else
      render json: @chat_room_member.errors, status: :unprocessable_entity
    end
  end

  # DELETE /chat_room_members/1
  def destroy
    @chat_room_member.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat_room_member
      @chat_room_member = ChatRoomMember.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def chat_room_member_params
      params.require(:chat_room_member).permit(:chat_room_id, :user_id)
    end
end
