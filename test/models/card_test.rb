# frozen_string_literal: true

require 'test_helper'

class CardTest < ActiveSupport::TestCase
  def setup
    @card_one = cards(:japan)
    @card_two = cards(:one)
  end

  test 'Associated fronts and backs should be destroyed' do
    @card_one.save
    @card_one.fronts.create!(
      text_field: 'BLAH!'
    )
    @card_two.backs.create!(
      text_field: 'BLAH!'
    )
    assert_difference 'Front.count', -1 do
      @card_one.destroy
    end
    assert_difference 'Back.count', -1 do
      @card_two.destroy
    end
  end

  test 'Set interval works' do
    day1 = @card_one.day_to_study
    @card_one.set_interval('good')
    assert_not day1 == @card_one.day_to_study
    @card_two.set_interval('easy')
    assert_not @card_two.interval > 250
  end
end
