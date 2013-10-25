module Services
  def self.table_name_prefix
     'services_'
   end
  
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
    path = File.join(Rails.root, "app", "models", "services", "*")
    Dir.glob(path).map do |file| 
      File.basename(file, '.rb').camelize
    end.map{|c| const_get(c, false)}  end
  
  def self.destinations
    services.select do |service|
      service.respond_to?(:destination?) && service.destination?
    end
  end

  def self.sources
    services.select do |service|
      service.respond_to?(:source?) && service.source?
    end
  end
  
end