class ChatsController < ApplicationController
  before_action :set_chat, only: [:show, :update, :destroy]

  # GET /chats
  def index
    @chats = Chat.all
    @chats = @chats.where(chat_room_id: params[:chat_room_id]) if params[:chat_room_id].present?
    @chats.includes(user: [{}])
    render json: @chats, include: :user
  end

  # GET /chats/1
  def show
    render json: @chat
  end

  # POST /chats
  def create
    chat_params
    current_user = User.find_by_token(params[:token])
    @chat = Chat.new(
        user_id: current_user.id,
        chat_room_id: params[:chat_room_id],
        message: params[:message]
    )

    if @chat.save
      render json: @chat, status: :created, location: @chat
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /chats/1
  def update
    if @chat.update(chat_params)
      render json: @chat
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  # DELETE /chats/1
  def destroy
    @chat.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @chat = Chat.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def chat_params
      params.permit(:user_id, :chat_room_id, :message)
    end
end
