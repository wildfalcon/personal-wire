class Destination < ActiveRecord::Base
  
  # Scopes
  scope :enabled, -> { where(enabled: true) }
  scope :disabled, -> { where(enabled: false) }

  # Associations
  has_many :postings
  has_many :photos, through: :postings
  belongs_to :destination_strategy, polymorphic: true, dependent: :destroy

  # Delegations
  delegate :destination_name, to: :destination_strategy
  
  # Class methods
  def self.primary
    enabled.select do |d| 
      d.destination_strategy.class.to_s == "Destinations::Wordpress"
    end.first
  end
  
  def self.secondary
    enabled.reject{|d| d.id == self.primary.id}
  end
  
  # Instant methods
  def post!(photo)
    posting = postings.build
    posting.photo = photo
    url, result = destination_strategy.post!(photo)
    posting.response = result
    posting.save
    
    # Return the URL if we got it
    url
  end
end
