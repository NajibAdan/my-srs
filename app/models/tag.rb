# frozen_string_literal: true

class Tag < ApplicationRecord
  # Relationship for Taggings and Cards
  has_many :taggings
  has_many :cards, through: :taggings, dependent: :destroy

  belongs_to :user
end
