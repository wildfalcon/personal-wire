class DestinationsController < ApplicationController

  def new
    destination_name = params[:service]
    destination = Services.destinations.select{|d| d.service_name == destination_name}.first
    if destination.respond_to?(:new_redirect_path)
      redirect_to destination.new_redirect_path
    else
      set_instance_variables(destination)
      render destination_name
    end
  end
  
  def create
    destination_name = params[:service]
    destination = Services.destinations.select{|d| d.service_name == destination_name}.first
    destination.create_service(params, env["omniauth.auth"])
    redirect_to root_path
  end
     
  def set_instance_variables(destination)
    if destination.respond_to?(:set_new_view_variables)
      vars = destination.set_new_view_variables(params[:service_id])
      vars.each do |name, value|
        instance_variable_set(("@#{name}").to_sym, value)
      end
    end
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
