class Destinations::Facebook < ActiveRecord::Base

  def self.enabled?
    ENV['FB_ID'].present? && ENV['FB_SECRET'].present?
  end

  def self.name
    "Facebook"
  end

end
