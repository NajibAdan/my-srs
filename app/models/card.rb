class Card < ApplicationRecord
    #Relationship for deck
    belongs_to :deck

    #Relationship for Front and Back
    has_many :fronts, dependent: :destroy
    has_many :backs, dependent: :destroy
    accepts_nested_attributes_for :fronts
    accepts_nested_attributes_for :backs
    
    #Relationship for Taggings and Tag
    has_many :taggings
    has_many :tags, through: :taggings, dependent: :destroy 
 
end
