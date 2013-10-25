module Services
  
  def self.available
    services.select(&:available?)
  end
  
  def self.unavailable
    services.reject(&:available?)
  end
  
  def self.find_by_provider(provider)
    available.select{|service| service.provider_name == provider}
  end
  
  def self.services
    destinations+sources
  end
  
  def self.destinations
    path = File.join(Rails.root, "app", "models", "destinations", "*")
    Dir.glob(path).map do |file| 
      File.basename(file, '.rb').camelize
    end.map{|c| Destinations.const_get(c, false)}
  end

  def self.sources
    path = File.join(Rails.root, "app", "models", "sources", "*")
    sources = Dir.glob(path).map do |file| 
      File.basename(file, '.rb').camelize
    end.map{|c| Sources.const_get(c, false)}
  end
  
end