# frozen_string_literal: true

require "test_helper"

class CommentTest < ActiveSupport::TestCase
  setup do
    @blog = create(:blog, title: 'unique title')
  end

  test 'Should create comment' do
    assert_difference('Comment.count') do
      @blog.comments.create(attributes_for(:comment))
    end
  end

  test 'Should not create empty comment' do
   comment = @blog.comments.create(attributes_for(:comment, body: nil))
   assert comment.errors[:body].present?, 'expects a comment cannot be empty error'
  end
end
