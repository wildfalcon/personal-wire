class Destinations::Wordpress < ActiveRecord::Base

  def self.available?
    true
  end

  def self.service_name
    "Wordpress"
  end

  def self.provider_name

  end

  def self.config_path
    {"config" => "/destinations/wordpress/new"}
  end


  has_one :destination, as: :destination_strategy

  def destination_name
    "#{self.class.service_name} - #{host}"
  end


  def post!(photo)
    title = photo.title || "New Post"
    caption = photo.caption || "New Photo"
    
    wp = Rubypress::Client.new(:host => host,
                               :username => username,
                               :password => password)

    blog_id = wp.getOptions["blog_id"]["value"]

    # First post the image
    image_response = wp.uploadFile(:blog_id => blog_id,
                                   :username => username,
                                   :password => password,
                                   :data => {:name => photo.photo.name,
                                             :type => photo.photo.send(:job).mime_type,
                                             :bits => XMLRPC::Base64.new(photo.photo.data)})
    image_id = image_response["id"]
    

    # Now make a post, using the image
    post_id = wp.newPost(:blog_id => blog_id,
                         :username => username,
                         :password => password,
                         :content => {:post_title => title,
                                      :post_content=> caption,
                                      :post_thumbnail => image_id,
                                      :post_status => "publish"})
                                      
    post_data = wp.getPost(:blog_id => blog_id,
                        :username => username,
                        :password => password,
                        :post_id => post_id)

    # URL (if any), and entire result
    return post_data["link"], post_data

  end
end
