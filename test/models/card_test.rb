require 'test_helper'

class CardTest < ActiveSupport::TestCase
  def setup 
    @cardOne = cards(:test)
    @cardTwo = cards(:one)
  end

  test 'Associated fronts and backs should be destroyed' do
    @cardOne.save
    @cardTwo
    @cardOne.fronts.create!(
      text_field: 'BLAH!'
    )
    @cardTwo.backs.create!(
      text_field: 'BLAH!'
    )
    assert_difference "Front.count", -1 do
      @cardOne.destroy
    end
    assert_difference "Back.count", -1 do
      @cardTwo.destroy
    end
  end
end
