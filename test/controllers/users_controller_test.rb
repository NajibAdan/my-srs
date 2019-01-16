require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test 'a user should sign up/log in first' do
    get user_path(1)
    assert_redirected_to user_session_url
  end
  test 'should get the signup page' do 
    get new_user_registration_path 
    assert_response :success
  end
end
