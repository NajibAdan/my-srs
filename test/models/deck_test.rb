require 'test_helper'

class DeckTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup 
    @deck = decks(:nothingness)
    @nothing = decks(:nothing)
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

  test 'study should provide a random card when called' do
    assert_not @nothing.study.first == @nothing.study.first
  end
end
