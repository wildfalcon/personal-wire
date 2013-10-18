class Destinations::FacebookPage < ActiveRecord::Base
  def self.enabled?
    Destinations::Facebook.count > 0
  end

  def self.destination_service_name
    "Facebook Page"
  end

  def self.provider_name
    "not-implemented"
  end

  def self.register(user_hash)

  end

  def destination_name
    "#{self.class.destination_service_name} - #{name}"
  end

end
