# frozen_string_literal: true

require 'test_helper'

class DeckTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @deck = decks(:nothingness)
    @nothing = decks(:nothing)
  end

  test 'associated cards should be destroyed' do
    temp_params = {
      fronts_attributes: [{ text_field: 'blah' }],
      backs_attributes: [{ text_field: 'blah' }]
    }
    @deck.save
    @deck.cards.create!(temp_params)
    assert_difference 'Card.count', -1 do
      @deck.destroy
    end
  end

  test 'due_card should provide a random card when called' do
    random_card = @nothing.due_cards.first
    another_random_card = @nothing.due_cards.first
    assert_not random_card == another_random_card
  end

  test 'due_card function only returns due cards' do
    due_deck = decks(:nothing) # deck with due cards
    no_due_deck = decks(:test) # deck without due cards
    5.times do # loop through the assert 5 times
      assert_not due_deck.due_cards.blank? # assert the queue is not empty
      random_card = due_deck.due_cards.first
      assert no_due_deck.due_cards.blank? # assert the queue is empty
      assert random_card.day_to_study <= Date.today
    end
  end
end
