# frozen_string_literal: true

require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @blog = create(:blog_with_comments)
    @token = authenticated_user[0]
  end

  test "should get index" do
    get blog_comments_url(@blog),
    headers: {"Accept": "application/vnd.api+json", "Authorization": @token["auth_token"]}
    assert_response :success
  end
  
  test "should create comment" do
    assert_difference("Comment.count") do
      post blog_comments_url(blog_id: @blog.id), params: { data:{'type': 'comment', 'attributes':{body:'New comment which shows'}}},
      headers: {"Accept": "application/vnd.api+json", "Authorization": @token["auth_token"]}
    end
    assert_response 201
  end

  test "should show comment" do
    get blog_comments_url(id: @blog.comments.last, blog_id: @blog.id),
    headers: {"Accept": "application/vnd.api+json", "Authorization": @token["auth_token"]}
    assert_response :success
  end

  test "should only update comment if blog owner" do
    patch blog_comment_url(id: @blog.comments.last, blog_id: @blog.id), params: { data:{'type': 'comment', 'attributes':{body:'The updated comment'}}}, 
    headers: {"Accept": "application/vnd.api+json", "Authorization": @token["auth_token"]}
    assert_response 401
  end

  test "should destroy comment if blog owner" do
      delete blog_comment_url(id: @blog.comments.last, blog_id: @blog.id),
      headers: {"Accept": "application/vnd.api+json", "Authorization": @token["auth_token"]}
    assert_response 401
  end
end
