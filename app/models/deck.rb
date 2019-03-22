# frozen_string_literal: true

class Deck < ApplicationRecord
  # Relationship for User
  belongs_to :user

  # Relationship for Cards
  has_many :cards, dependent: :destroy

  # Validations
  validates :name, presence: true
  belongs_to :option
  # Returns due cards
  def due_cards
    @due_cards = cards.where(
      day_to_study: nil
    ).or(cards.where(
           day_to_study: Date.today
         )).or(cards.where('day_to_study <  ?', Date.today)).order(Arel.sql('random()'))
  end

  def studied
    cards.where(
      'day_to_study > ?', Date.today.strftime('%d/%m/%Y')
    )
         .count
  end
end
