

desc "Post a single photo"
task :post_a_photo => :environment do
  if [1,3,6].include?(Time.now.wday) 
    photo = Photo.unpublished.random.first.post!
  end
end

desc "Import all new photos"
task :import_photos => :environment do
  Source.enabled.all.each do |source|
    source.build_imports!
    source.import_photos!
  end
end

task :import_and_post => [:import_photos, :post_a_photo]
