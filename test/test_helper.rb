# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include ApplicationHelper
  def login(user)
    post user_session_path, 'user[email]' => user.email, 'user[password]' => user.password
  end

  def signed_in?
    !session[:user_id].nil?
  end
end
