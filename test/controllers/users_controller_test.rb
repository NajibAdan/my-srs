# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:blank)
    @other_user = users(:blake)
    @admin = users(:big_guy)
  end
  test 'a user should sign up/log in first' do
    get user_path(1)
    assert_redirected_to user_session_url
  end
  test 'should get the signup page' do
    get new_user_registration_path
    assert_response :success
  end

  test 'should not allow the admin attribute to be edited via the web' do
    login_as(@other_user)
    assert_not @other_user.admin?
    patch user_path(@other_user), params: {
      user: { password: 'password',
              password_confirmation: 'password',
              admin: true }
    }
    assert_not @other_user.admin?
  end

  test "A user shouldn't destroy/edit/update another user" do
    login_as @user
    patch user_path(@other_user), params: {
      user: { password: 'password',
              password_confirmation: 'password',
              admin: true }
    }
    assert_redirected_to root_url
    delete user_path(@other_user), params: {
      user: { password: 'password',
              password_confirmation: 'password',
              admin: true }
    }
    assert_redirected_to root_url
  end

  test 'Only an admin can delete another user' do
    login_as @user
    delete user_path(@other_user), params: {
      user: { password: 'password',
              password_confirmation: 'password',
              admin: true }
    }
    assert_redirected_to root_url
    login_as @admin
    delete user_path(@other_user), params: {
      user: { password: 'password',
              password_confirmation: 'password',
              admin: true }
    }
    assert_redirected_to users_url
  end

  test 'The index page for user should be only visible to admins' do
    login_as @user
    get users_path
    assert_redirected_to user_session_url
  end
end
