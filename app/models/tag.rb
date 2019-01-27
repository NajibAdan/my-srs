class Tag < ApplicationRecord
    #Relationship for Taggings and Cards
    has_many :taggings
    has_many :cards, through: :taggings, dependent: :destroy
end
