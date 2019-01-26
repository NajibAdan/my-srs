class Deck < ApplicationRecord
    belongs_to :user
    has_many :cards, dependent: :destroy
    validates :name, presence: true
    def study
        @study = self.cards.where(day_to_study: '')
    end
end
