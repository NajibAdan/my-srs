require 'test_helper'

class CardTest < ActiveSupport::TestCase
  def setup 
    @cardOne = cards(:japan)
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

  test 'Set interval works' do
    day1 = @cardOne.day_to_study
    @cardOne.set_interval('good')
    assert_not day1==@cardOne.day_to_study
    @cardTwo.set_interval('easy')
    assert_not @cardTwo.interval > 250
  end
end
