class Import < ActiveRecord::Base

  # Associations
  belongs_to :photo
  belongs_to :source
  
  # Serializations
  # don't know yet if I want to seerialize this
  #serialize :key


  def import_photo!
    return if photo.present?
    photo_file = source.get_photo_file(key)
    photo = build_photo
    photo.photo = photo_file
    save
  end
end
