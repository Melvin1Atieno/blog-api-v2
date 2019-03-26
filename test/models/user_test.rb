# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase

  test 'should not save user with missing credentials' do
    @new_user = User.create
    assert @new_user.errors[:username].present?, 'expect missing username error'
    assert @new_user.errors[:email].present?, 'expects missing email error'
    assert @new_user.errors[:password].present?, 'expects missing password error'
  end

  test 'should not save user with invalid credentials' do
    @new_user = User.create(username: 'm', email:'me', password: 'no')
    assert @new_user.errors[:username].present?, 'expect invalid username error'
    assert @new_user.errors[:email].present?, 'expects invalid email error'
    assert @new_user.errors[:password].present?, 'expects invalid password error'
  end

  test 'should save user with valid credentials' do
    assert_difference('User.count') do
      User.create(attributes_for(:user))
    end
  end

  test 'user can have many posts' do
    @user_with_blogs = create(:user_with_blogs)
    assert_equal 5, @user_with_blogs.blogs.size
  end
end
