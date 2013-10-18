class Photo < ActiveRecord::Base

  dragonfly_accessor :photo

  has_many :postings
  has_many :destinations, through: :postings

  scope :unpublished, -> { where(published: false) }
  scope :published, -> { where(published: true) }

  def post!
    self.url = Destination.primary.post!(self) if Destination.primary.present?
    
    Destination.secondary.each do |destination|
      destination.post!(self)
    end
    
    self.published = true
    self.save
  end

end
