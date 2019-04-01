require 'test_helper'

class ChatRoomMembersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @chat_room_member = chat_room_members(:one)
  end

  test "should get index" do
    get chat_room_members_url, as: :json
    assert_response :success
  end

  test "should create chat_room_member" do
    assert_difference('ChatRoomMember.count') do
      post chat_room_members_url, params: { chat_room_member: { chat_room_id: @chat_room_member.chat_room_id, user_id: @chat_room_member.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show chat_room_member" do
    get chat_room_member_url(@chat_room_member), as: :json
    assert_response :success
  end

  test "should update chat_room_member" do
    patch chat_room_member_url(@chat_room_member), params: { chat_room_member: { chat_room_id: @chat_room_member.chat_room_id, user_id: @chat_room_member.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy chat_room_member" do
    assert_difference('ChatRoomMember.count', -1) do
      delete chat_room_member_url(@chat_room_member), as: :json
    end

    assert_response 204
  end
end
