# frozen_string_literal: true

require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  def setup
    @user = users(:blank)
  end
  test 'flash should not persist' do
    get user_session_path
    assert_template 'devise/sessions/new'
    post user_session_path params: { session: { email: '', password: '' } }
    assert_template 'devise/sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test 'successful login' do
    get user_session_path
    assert_template 'devise/sessions/new'
    login_as @user
    get user_path(@user)

    assert_select 'h2', text: "#{@user.name}'s stats"
  end

  test 'login with valid credentials and logout' do
    get user_path(@user)
    assert_redirected_to user_session_path
    follow_redirect!
    login_as @user
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'a[href=?]', new_user_session_path, count: 0
    assert_select 'a[href=?]', destroy_user_session_path
    assert_select 'a[href=?]', user_path(@user)
    delete destroy_user_session_path
    assert_redirected_to root_url
    delete destroy_user_session_path
    follow_redirect!
    assert_select 'a[href=?]', new_user_session_path
    assert_select 'a[href=?]', destroy_user_session_path, count: 0
    assert_select 'a[href=?]', user_path(@user), count: 0
  end
end
