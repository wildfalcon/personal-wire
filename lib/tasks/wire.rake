

desc "Post a single photo"
task :post_a_photo => :environment do
  photo = Photo.unpublished.random.first.post!
end

desc "Import all new photos"
task :import_photos => :environment do
  Source.all.each do |source|
    source.build_imports!
    source.import_photos!
  end
end

task :import_and_post => [:import_photos, :post_a_photo]
