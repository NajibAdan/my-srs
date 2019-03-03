# frozen_string_literal: true

require 'test_helper'

class DecksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  def setup
    @deck = decks(:japan)
  end

  test 'should redirect create to login page when not logged in' do
    assert_no_difference 'Deck.count' do
      post decks_path, params: { deck: { name: 'Should fail' } }
    end
    assert_redirected_to user_session_url
  end

  test 'should redirect delete to login when not logged in' do
    assert_no_difference 'Deck.count' do
      delete deck_path(@deck)
    end
    assert_redirected_to user_session_url
  end

  test 'A user cant delete another users deck ' do
    login_as users(:blake)
    assert_no_difference 'Deck.count' do
      delete deck_path(@deck)
    end
    assert_redirected_to user_session_url
  end
end
