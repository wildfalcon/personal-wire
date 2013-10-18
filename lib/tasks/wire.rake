desc "Import some sample photos"
task :import_sample_photos => :environment do
  URLS = ["http://farm6.staticflickr.com/5545/10213401616_56324ce5c6_b.jpg",
   "http://farm8.staticflickr.com/7313/10175904546_93b09b4b43_b.jpg",
   "http://farm6.staticflickr.com/5445/10140326634_ea81dd0432_b.jpg"]
   
   URLS.each do |url|
     p = Photo.new
     p.photo_url = url
     p.save
  end 
end

desc "Post a single photo"
task :post_a_photo => :environment do
  photo = Photo.unpublished.first.post!
end

# desc "Import some sample photos"
# task :import_dropbox_photos => :environment do
#   require 'nokogiri'
#   require 'open-uri'
#   url = "https://www.dropbox.com/sh/bfys3adirsyl7kj/HoMDzYvQd3/nb-demo"
#   doc = Nokogiri::HTML(open(url))
#   urls = doc.css("img").map{|node| node.attr("href")}
#   # puts urls.class
#   # puts urls.inspect
#   urls = urls.compact.select{|u| u.match(/jpg/)}.uniq
#   # puts urls
#   
#    
#    urls.each do |url|
#      p = Photo.new
#      p.photo_url = url
#      p.save
#   end 
# end
