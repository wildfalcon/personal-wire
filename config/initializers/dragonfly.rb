require 'dragonfly'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  protect_from_dos_attacks true
  secret "4n9czqqe8tqeeqoe12xuw"

  url_format "/media/:job/:name"

  if Rails.env.production?
    datastore :s3,
      bucket_name: ENV['S3_BUCKET'],
      access_key_id: ENV['S3_KEY'],
      secret_access_key: ENV['S3_SECRET']
  else
    datastore :file,
      root_path: Rails.root.join('public/system/dragonfly', Rails.env),
      server_root: Rails.root.join('public')
  end
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
end
