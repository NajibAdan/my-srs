require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  def setup
    @user = users(:blank)
  end
  test 'flash should not persist' do 
    get user_session_path
    assert_template 'devise/sessions/new'
    post user_session_path params: {session: {email: '',password: ''}}
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

    assert_select 'p', text: "User: #{@user.username}"
  end
end
