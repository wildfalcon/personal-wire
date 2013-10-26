class SourcesController < ApplicationController
  def new
    source_name = params[:service]
    source = Services.sources.select{|d| d.service_name == source_name}.first
    redirect_to source.new_redirect_path
  end
  
  def create
    source_name = params[:service]
    source = Services.sources.select{|d| d.service_name == source_name}.first
    instance = source.create_service(params, env["omniauth.auth"])
    redirect_to edit_source_path(instance.source)
  end
  
  def edit
    source = Source.find(params[:id])
    @strategy = source.source_strategy
    render @strategy.class.service_name
  end

  def update
    source = Source.find(params[:id])
    strategy = source.source_strategy
    strategy.update_attributes(params[strategy.class.table_name.singularize.to_sym])
    strategy.save
    redirect_to root_path
  end
  
  def enable
    source = Source.find_by_id params[:id]
    source.enabled = true
    source.save
    redirect_to root_path
  end
  
  def disable
    source = Source.find_by_id params[:id]
    source.enabled = false
    source.save
    redirect_to root_path
  end
end
