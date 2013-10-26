class Services::Facebook < ActiveRecord::Base

  def self.available?
    ENV['FB_ID'].present? && ENV['FB_SECRET'].present?
  end

  def self.service_name
    "facebook"
  end
  
  def self.destination?
    true
  end
  
  def self.new_redirect_path
    "/auth/facebook"
  end
    
  def self.config_path
    {"Add Destination" => "/destinations/facebook/new"}
  end
  
  def self.create_service(params, omniauth_hash)
    name = omniauth_hash["info"]["name"]
    uid = omniauth_hash["uid"]
    token = omniauth_hash["credentials"]["token"]
    
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
