# frozen_string_literal: true

require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = build(:user)
    @saved_user = create(:user)
  end

  test "should get index" do
    get users_url, as: :json
    assert_response :success
  end

  test "should create user" do
    post users_url, params: {data: {'type': 'user','attributes':attributes_for(:user)}},
    headers: {'Accept': 'application/vnd.api+json'}
    binding.pry
    assert_response 201
  end

  test "should show user" do
    get user_url(@saved_user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@saved_user), params:{data: { 'type': 'user', 'attributes':attributes_for(:user)} },
    headers: {'Accept': 'application/vnd.api+json'}
    assert_response 200
  end

  test "should destroy user" do
    assert_difference("User.count", -1) do
      delete user_url(@saved_user), as: :json
    end

    assert_response 204
  end
end
