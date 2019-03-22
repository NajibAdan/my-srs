# frozen_string_literal: true

require 'test_helper'

class StudyTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  def setup
    @nothing = decks(:nothing)
  end
  test 'imitating the studying procedure' do
    # login as user
    login_as users(:cray)
    # replicating the study procedure
    count_of_cards_due = @nothing.due_cards.count
    count_of_cards_due.times do |i|
      get study_path(id: @nothing.id) # gets the study page for a deck
      assert_response :success
      card_to_study = @nothing.due_cards.first # gets the first card from the queue
      post study_path, params: { card: { card_id: card_to_study.id,
                                         deck_id: @nothing.id }, commit: 'easy' }
      card_to_study.scheduler('easy')
      # assert the user is still in the study page
      assert_redirected_to study_url(id: @nothing.id)
      # assert the card has been scheduled for a later date
      assert card_to_study.day_to_study > Date.today
      # after the last card has been studied assert the user
      # is directed to the index deck page
      if i == count_of_cards_due
        follow_redirect!
        assert_redirected_to decks_url
      end
    end
  end
end
