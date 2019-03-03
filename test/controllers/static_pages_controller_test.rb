# frozen_string_literal: true

require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test 'should get root' do
    get root_path
    assert_response :success
  end
  test 'should get home' do
    get home_path
    assert_response :success
  end
  test 'should get about' do
    get about_path
    assert_response :success
  end
  test 'should get contact' do
    get contact_path
    assert_response :success
  end
end
