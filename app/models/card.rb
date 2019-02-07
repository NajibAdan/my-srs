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
end
