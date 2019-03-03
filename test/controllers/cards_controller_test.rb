# frozen_string_literal: true

require 'test_helper'

class CardsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  def setup
    @card = cards(:test)
  end
  test 'should redirect create to login page when not logged in' do
    assert_no_difference 'Card.count' do
      post cards_path, params: { card: {
        front_attributes: { text_field: 'BLAH!' },
        back_attributes: { text_field: 'Blah!' }
      } }
    end
    assert_redirected_to user_session_url
  end

  test 'should redirect delete to login when not logged in' do
    assert_no_difference 'Deck.count' do
      delete card_path(id: @card, deck: @card.deck)
    end
    assert_redirected_to user_session_url
  end

  test "A user can't delete another user's card" do
    login_as users(:blade)
    assert_no_difference 'Card.count' do
      delete card_path(id: @card, deck: @card.deck)
    end
    assert_redirected_to user_session_url
  end
end
