class Destinations::FacebookPage < ActiveRecord::Base
  def self.enabled?
    Destinations::Facebook.count > 0
  end

  def self.destination_service_name
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
    "#{self.class.destination_service_name} - #{name}"
  end

end