class Destinations::Facebook < ActiveRecord::Base

  def self.available?
    ENV['FB_ID'].present? && ENV['FB_SECRET'].present?
  end

  def self.service_name
    "Facebook"
  end
  
  def self.provider_name
    "facebook"
  end
  
  def self.config_path
    {"config" => "/auth/facebook"}
  end
  
  def self.register(user_hash)
    name = user_hash["info"]["name"]
    uid = user_hash["uid"]
    token = user_hash["credentials"]["token"]
    
    facebook = self.find_or_create_by_uid(uid)
    facebook.create_destination unless facebook.destination.present?
    facebook.token = token
    facebook.name = name
    facebook.save
  end
  
    has_one :destination, as: :destination_strategy
  
  def destination_name
    "#{self.class.service_name} - #{name}"
  end
  
  def pages
    Facepost.list_pages(token)
  end

end
