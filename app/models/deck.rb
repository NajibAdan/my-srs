class Deck < ApplicationRecord
    #Relationship for User
    belongs_to :user
    
    #Relationship for Cards
    has_many :cards, dependent: :destroy

    #Validations
    validates :name, presence: true

    #Returns due cards
    def study
        @study = self.cards.where(day_to_study: '')
    end
end
