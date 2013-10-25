class Services::FacebookPage < ActiveRecord::Base
  def self.available?
    Services::Facebook.count > 0
  end

  def self.service_name
    "Facebook Page"
  end
  
  def self.config_path
    paths = {} 
    Services::Facebook.all.each do |fb|
      paths["Add Destination: #{fb.name}"] = "/destinations/facebook_page/new/#{fb.id}"
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

  def post!(photo)
    title = photo.title
    caption = "Test - #{photo.caption}\n\n#{photo.url}"
    
    result = Facepost.post_photo(uid, token, photo.photo, "#{title} #{caption}")

    # URL (if any), and entire result
    return nil, result
  end


end
