class Destinations::Wordpress < ActiveRecord::Base

  def self.enabled?
    true
  end

  def self.destination_service_name
    "Wordpress"
  end

  def self.provider_name

  end

  def self.config_path
    {"config" => "/destinations/wordpress/new"}
  end


  has_one :destination, as: :destination_strategy

  def destination_name
    "#{self.class.destination_service_name} - #{host}"
  end

end
