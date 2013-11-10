class Photo < ActiveRecord::Base

  dragonfly_accessor :photo  
  dragonfly_accessor :small_photo do
    after_assign do |p|
      p.convert!('-resize 512x512> -quality 80', :jpg)
    end
  end

  has_many :postings
  has_many :destinations, through: :postings

  scope :unpublished, -> { where(published: false) }
  scope :published, -> { where(published: true) }
  scope :random, -> { order("RANDOM()") }

  def post!
    self.url = Destination.primary.post!(self) if Destination.primary.present?
    
    Destination.secondary.each do |destination|
      destination.post!(self)
    end
    
    self.published = true
    self.save
  end
  
  def read_caption
    EXIFR::JPEG.new(photo.file).image_description
  end
  
  after_create do |photo|
    photo.small_photo = photo.photo
    
    photo.title = photo.read_caption
    photo.caption = photo.title
    
    photo.save
  end

end
