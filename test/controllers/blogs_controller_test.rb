# frozen_string_literal: true

require "test_helper"

class BlogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @blog = create(:blog)
    @token = authenticated_user[0]
    @unsaved_blog = build(:blog)
  end

  test "should return unauthorized if token is missing" do
    get blogs_url,
    headers: {"Accept": "application/vnd.api+json"}
    assert_response :unauthorized
  end

  test "should get index" do
    get blogs_url,
    headers: {"Accept": "application/vnd.api+json", "Authorization": @token["auth_token"]}
    assert_response :success
  end

  test "should create blog" do
    assert_difference("Blog.count") do
      post blogs_url, params: {data: {'type': 'blog','attributes':{title: @unsaved_blog.title, body: @unsaved_blog.body}}},
      headers: {"Accept": "application/vnd.api+json", "Authorization": @token["auth_token"]}
    end
    assert_response 201
  end

  test "should show blog" do
    get blog_url(@blog), 
    headers: {"Accept": "application/vnd.api+json", "Authorization": @token["auth_token"]}
    assert_response :success
  end

  test "should only update own blog" do
    patch blog_url(@blog), params: { data: { 'type': 'blog', 'attributes':{title: @unsaved_blog.title}}},
    headers: {"Accept": "application/vnd.api+json", "Authorization": @token["auth_token"]}
    assert_response 401
  end

  test "should only destroy blog" do
    assert_no_difference("Blog.count") do
      delete blog_url(@blog),
      headers: {"Accept": "application/vnd.api+json", "Authorization": @token["auth_token"]}
    end
    assert_response 401
  end
end
