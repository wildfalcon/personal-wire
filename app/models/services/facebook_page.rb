class Services::FacebookPage < ActiveRecord::Base
  def self.available?
    Services::Facebook.count > 0
  end

  def self.destination?
    true
  end

  def self.service_name
    "facebook_page"
  end
  
  def self.config_path
    paths = {} 
    Services::Facebook.all.each do |fb|
      paths["Add Destination: #{fb.name}"] = "/destinations/facebook_page/new/#{fb.id}"
    end
    paths
  end

  def self.set_new_view_variables(account_id)
    facebook = Services::Facebook.find(account_id)
    {pages: facebook.pages, facebook_id: facebook.id}
  end
  
  def self.create_service(params, auth=nil)
    @facebook_id = params[:facebook_id]
    @page_uid = params[:service_id]
    facebook = Services::Facebook.find(@facebook_id)
    pages = facebook.pages
    page = pages.select{|p| p[:uid]==@page_uid}.first

    uid = page[:uid]
    name = page[:name]
    token = page[:token]

    facebook_page = Services::FacebookPage.find_or_create_by_uid(uid)
    facebook_page.create_destination unless facebook_page.destination.present?
    facebook_page.token = token
    facebook_page.name = name
    facebook_page.save
    
  end
  
  has_one :destination, as: :destination_strategy

  def destination_name
    "#{self.class.service_name} - #{name}"
  end

  def post!(photo)
    title = photo.title
    
    
    result = Facepost.post_photo(uid, token, photo.photo, "#{title}")

    # URL (if any), and entire result
    return nil, result
  end


end
