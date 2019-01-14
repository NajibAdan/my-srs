class Card < ApplicationRecord
    belongs_to :deck
    validates :front, presence: true
    validates :back,presence: true    
end
