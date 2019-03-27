# frozen_string_literal: true

require "test_helper"

class BlogTest < ActiveSupport::TestCase

  test 'Should create blog when valid attributes are provided' do
    assert_difference('Blog.count') do
      create(:blog, title: 'This is a new title')
    end
  end

  test 'should not create blog if provided attributes are invalid' do
    @blog = Blog.create( body: 'body too short')
    assert @blog.errors[:title].present?, 'expect title missing error'
    assert @blog.errors[:body].present?, 'expect too short body error'
  end

  test 'should delete associated comments when blog is deleted' do
    @blog = create(:blog_with_comments, title: 'This is a new title')
    assert_difference('Comment.count', -5) do
      @blog.destroy
    end
  end

end
