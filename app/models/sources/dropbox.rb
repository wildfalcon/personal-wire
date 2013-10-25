class Sources::Dropbox < ActiveRecord::Base
  require 'dropbox_sdk'
  
  SESSION = {}
  
  def self.available?
    ENV['DROPBOX_KEY'].present? && ENV['DROPBOX_SECRET'].present?
  end

  def self.service_name
    "Dropbox"
  end

  def self.config_path
    {"config" => "sources/dropbox/new"}
  end

  def self.flow
    flow = ::DropboxOAuth2Flow.new(ENV['DROPBOX_KEY'], 
                                   ENV['DROPBOX_SECRET'], 
                                   "https://personal-wire.dev/sources/dropbox/create",
                                    SESSION, :csrf)
  end

  def self.auth_url
    flow.start()
  end
  
  def self.finish(params)
    token, uid, state = flow.finish(params)
    
    dropbox = self.find_or_create_by_uid(uid)
    dropbox.create_source unless dropbox.source.present?
    dropbox.token = token
    dropbox.uid = uid
    dropbox.save
  end
  
  has_one :source, as: :source_strategy
  
  def client
    DropboxClient.new(token)
  end
  
  def account
    client.account_info
  end
  
  def list_files
    client.metadata(path)["contents"]
  end
  
  def import_photos
    list_files.each do |file|
      file_path = file["path"]
      contents, metadata = client.get_file_and_metadata file_path
      
      p = Photo.new
       p.photo = contents
       p.save
      
    end
  end
end
