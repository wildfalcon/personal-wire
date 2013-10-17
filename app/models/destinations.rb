module Destinations
  def self.table_name_prefix
    'destinations_'
  end
  
  def self.available
    services.select(&:enabled?)
  end
  
  def self.unavailable
    services.reject(&:enabled?)
  end
  
  def self.services
    path = File.join(Rails.root, "app", "models", "destinations", "*")
    Dir.glob(path).map{|file| File.basename(file, '.rb').camelize}.map{|c| const_get(c)}
  end
end
