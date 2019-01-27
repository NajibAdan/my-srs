class Card < ApplicationRecord
    #Relationship for deck
    belongs_to :deck

    #Relationship for Front and Back
    has_many :fronts, dependent: :destroy
    has_many :backs, dependent: :destroy

    #Relationship for Taggings and Tag
    has_many :taggings
    has_many :tags, through: :taggings, dependent: :destroy 

    #Validations which need to be removed
    validates :front, presence: true
    validates :back,presence: true    
end
