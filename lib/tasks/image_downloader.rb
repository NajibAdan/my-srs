# frozen_string_literal: true

require 'faker'
require 'open-uri'

10.times do |i|
  URI.parse(Faker::Avatar.image).open do |f|
    File.open("./seed_images/image_#{i}.jpg", 'wb') do |file|
      file.puts f.read
    end
  end
end
