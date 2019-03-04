# frozen_string_literal: true

class Tagging < ApplicationRecord
  # Relationship for cards and tags
  belongs_to :tag
  belongs_to :card
end
