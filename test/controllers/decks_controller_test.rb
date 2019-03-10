# frozen_string_literal: true

require 'test_helper'

class DecksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  def setup
    @deck = decks(:japan)
    @nothing = decks(:nothing)
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

  test 'Study should work' do
    login_as users(:some_weird_guy)
    20.times do
      get study_path(id: @nothing.id)
      assert_response :success
      card_to_study = @nothing.study.first
      post study_path, params: { card: { card_id: card_to_study.id,
                                         deck_id: @nothing.id }, commit: 'easy' }
      card_to_study.set_interval('easy')
      assert_redirected_to study_url(id: @nothing.id)
      assert card_to_study.day_to_study != Date.today
    end
  end
end
