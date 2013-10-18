class Photo < ActiveRecord::Base

  dragonfly_accessor :photo

  scope :unpublished, -> { where(published: false) }
  scope :published, -> { where(published: true) }

end
