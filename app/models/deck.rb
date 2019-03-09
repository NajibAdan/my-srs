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
  def study
    @study = cards.where(
      day_to_study: nil
    ).or(cards.where(
           day_to_study: Date.today.strftime('%d/%m/%Y')
         )).or(cards.where("day_to_study <  ?",Date.today.strftime('%d/%m/%Y'))).order(Arel.sql('random()'))
  end

  def studied
    cards.where(
      'day_to_study > ?', Date.today.strftime('%d/%m/%Y')
    )
         .count
  end
end
