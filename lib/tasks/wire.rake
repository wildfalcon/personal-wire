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