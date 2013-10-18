class Destinations::FacebookPage < ActiveRecord::Base
  def self.available?
    Destinations::Facebook.count > 0
  end

  def self.service_name
    "Facebook Page"
  end
  
  def self.config_path
    paths = {} 
    Destinations::Facebook.all.each do |fb|
      paths[fb.name] = "/destinations/facebook_page/#{fb.id}"
    end
    paths
  end

  def self.provider_name
    "not-implemented"
  end

  def self.register(user_hash)

  end
  
  has_one :destination, as: :destination_strategy

  def destination_name
    "#{self.class.service_name} - #{name}"
  end

  def post(photo, title = "New Photo", caption = "New photo uploaded")
    Facepost.post_photo(uid, token, photo.photo, "#{title} #{caption}")
  end


end
