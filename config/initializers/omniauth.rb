Rails.application.config.middleware.use OmniAuth::Builder do  


  provider :facebook, ENV["FB_ID"], 
                      ENV["FB_SECRET"], 
                      :scope => "email,publish_stream,offline_access,user_photos,manage_pages"                      

end
