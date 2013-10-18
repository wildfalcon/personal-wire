class DestinationsController < ApplicationController
  def make_avialble
    user_hash = env["omniauth.auth"]
    provider = user_hash["provider"]
    Destinations.find_by_provider(provider).first.register(user_hash)
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
