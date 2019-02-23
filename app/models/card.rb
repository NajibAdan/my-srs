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
    
    def tag_list
        self.tags.collect do |tag|
            tag.name
        end.join(", ")
    end
    def tag_list=(tags_string)
        tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
        new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name,user_id:User.current.id) }
        self.tags = new_or_found_tags
    end

    def set_interval(response)
        option = self.deck.option
        case response
        when 'easy'
            next_interval = self.ease * self.interval * (option.easyBonus/100)
            new_ease = self.ease + 0.15
        when 'hard'
            next_interval = (self.interval * (option.newInterval/100)) * self.interval
            new_ease = self.ease - 0.20
        else
            next_interval = self.interval * self.ease * (option.intervalModifier/100)
            new_ease = self.ease
        end
        day_to_study = Date.today + next_interval/100
        self.update_attributes(interval: next_interval,ease: new_ease,day_to_study: day_to_study)
    end
end
