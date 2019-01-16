require 'test_helper'

class DeckTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup 
    @deck = decks(:japan)
  end

  test "associated cards should be destroyed" do
    @deck.save
    @deck.cards.create!(front: "test",back: "test")
    assert_difference "Card.count", -1 do
      @deck.destroy
    end
  end
end
