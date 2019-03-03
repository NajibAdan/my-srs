# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }
  has_many :decks, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :options, dependent: :destroy
  def self.current
    Thread.current[:user]
  end

  def self.current=(user)
    Thread.current[:user] = user
  end

  def cards_studied
    sum = 0
    decks.each do |deck|
      sum += deck.studied
    end
    sum
  end

  def cards_to_be_studied
    sum = 0
    decks.each do |deck|
      sum += deck.study.count
    end
    sum
  end
end
