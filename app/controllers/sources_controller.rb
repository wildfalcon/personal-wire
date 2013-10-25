class SourcesController < ApplicationController
  def dropbox_new
    redirect_to Sources::Dropbox.auth_url
  end

  def dropbox_create
    Sources::Dropbox.finish(params)
    redirect_to root_url
  end
end
