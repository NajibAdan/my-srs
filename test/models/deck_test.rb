require 'test_helper'

class DeckTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup 
    @deck = decks(:nothing)
  end

  test "associated cards should be destroyed" do
    temp_params = {
      fronts_attributes: [{text_field: 'blah'}],
      backs_attributes: [{text_field: 'blah'}]
    }
    @deck.save
    @deck.cards.create!(temp_params)
    assert_difference "Card.count", -1 do
      @deck.destroy
    end
  end
end
