class DestinationsController < ApplicationController

  def new
    destination_name = params[:service]
    destination = Services.destinations.select{|d| d.service_name == destination_name}.first
    if destination.respond_to?(:new_redirect_path)
      redirect_to destination.new_redirect_path
    else
      render destination_name
    end
  end
  
  def create
    destination_name = params[:service]
    destination = Services.destinations.select{|d| d.service_name == destination_name}.first
    destination.create_service(params, env["omniauth.auth"])
    redirect_to root_path
  end
  
  
    
  def list_facebook_page
    @facebook_id = params[:facebook_id]
    facebook = Destinations::Facebook.find(@facebook_id)
    @pages = facebook.pages
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
