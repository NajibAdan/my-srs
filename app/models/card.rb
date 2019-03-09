# frozen_string_literal: true

# Card class
class Card < ApplicationRecord
  before_create :create_checks
  before_update :update_checks
  # Relationship for deck
  belongs_to :deck

  # Relationship for Front and Back
  has_many :fronts, dependent: :destroy
  has_many :backs, dependent: :destroy
  accepts_nested_attributes_for :fronts
  accepts_nested_attributes_for :backs

  # Relationship for Taggings and Tag
  has_many :taggings
  has_many :tags, through: :taggings, dependent: :destroy

  def tag_list
    tags.collect(&:name).join(', ')
  end

  def tag_list=(tags_string)
    tag_names = tags_string.split(',').collect { |s| s.strip.downcase }.uniq
    new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name, user_id: User.current.id) }
    self.tags = new_or_found_tags
  end

  def set_interval(response)
    option = deck.option
    case response
    when 'easy'
      next_interval = ease * interval * (option.easyBonus / 100)
      new_ease = ease + 0.15
    when 'hard'
      next_interval = (interval * (option.newInterval / 100)) * interval
      new_ease = ease - 0.20
    else
      next_interval = interval * ease * (option.intervalModifier / 100)
      new_ease = ease
    end
    day = Date.today + next_interval / 100
    update_attributes!(day_to_study: day, interval: next_interval/100, ease: new_ease)
  end

  private

  def create_checks
    self.interval = 1
    self.day_to_study = Date.today
  end

  def update_checks
    self.interval = 1 if interval < 1
  end
end
