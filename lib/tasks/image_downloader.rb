require 'faker'
require 'open-uri'

10.times do |i|
    open(Faker::Avatar.image) { |f|
        File.open("./seed_images/image_#{i}.jpg","wb") do |file|
            file.puts f.read
        end
    }
end