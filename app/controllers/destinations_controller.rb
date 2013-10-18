class DestinationsController < ApplicationController
  def new_destination_service
    user_hash = env["omniauth.auth"]
    provider = user_hash["provider"]
    Services.find_by_provider(provider).first.register(user_hash)
    redirect_to root_path
  end
  
  def list_facebook_page
    @facebook_id = params[:facebook_id]
    facebook = Destinations::Facebook.find(@facebook_id)
    @pages = facebook.pages
  end
  
  def wordpress_new
  end
  
  def wordpress_create
    host = params[:host]
    username = params[:username]
    password = params[:password]
    
    
    wordpress = Destinations::Wordpress.find_or_create_by_host(host)
    wordpress.create_destination unless wordpress.destination.present?
    wordpress.username = username
    wordpress.password = password
    wordpress.save
    redirect_to root_path
  end
  
  
  def add_facebook_page
    @facebook_id = params[:facebook_id]
    @page_uid = params[:uid]
    facebook = Destinations::Facebook.find(@facebook_id)
    pages = facebook.pages
    page = pages.select{|p| p[:uid]==@page_uid}.first

    uid = page[:uid]
    name = page[:name]
    token = page[:token]

    facebook_page = Destinations::FacebookPage.find_or_create_by_uid(uid)
    facebook_page.create_destination unless facebook_page.destination.present?
    facebook_page.token = token
    facebook_page.name = name
    facebook_page.save
    redirect_to root_path
    

  end
    
  
  def enable
    destination = Destination.find_by_id params[:id]
    destination.enabled = true
    destination.save
    redirect_to root_path
  end
  
  def disable
    destination = Destination.find_by_id params[:id]
    destination.enabled = false
    destination.save
    redirect_to root_path
  end
  
end
