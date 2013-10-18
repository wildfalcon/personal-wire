class Posting < ActiveRecord::Base

  # Associations
  belongs_to :photo
  belongs_to :destination
  
  # Serializations
  serialize :response
end
