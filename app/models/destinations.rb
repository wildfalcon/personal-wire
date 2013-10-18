module Destinations
  def self.table_name_prefix
    'destinations_'
  end
  
  def self.configured_and_enabled
    configured.select(&:enabled?)
  end

  def self.configured_and_disabled
    configured.reject(&:enabled?)
  end
  
  def self.configured
    available.map(&:all).flatten.map(&:destination)
  end
  
  def self.available
    services.select(&:enabled?)
  end
  
  def self.unavailable
    services.reject(&:enabled?)
  end
  
  def self.find_by_provider(provider)
    available.select{|service| service.provider_name == provider}
  end
  
  def self.services
    path = File.join(Rails.root, "app", "models", "destinations", "*")
    Dir.glob(path).map{|file| File.basename(file, '.rb').camelize}.map{|c| const_get(c)}
  end
end
