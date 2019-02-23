class Deck < ApplicationRecord
    #Relationship for User
    belongs_to :user
    
    #Relationship for Cards
    has_many :cards, dependent: :destroy

    #Validations
    validates :name, presence: true
    belongs_to :option
    #Returns due cards
    def study
        @study = self.cards.where(
            day_to_study: nil).or(self.cards.where(
            day_to_study: Date.today.strftime("%d/%m/%Y"))
            ).order(Arel.sql('random()'))
    end
end
