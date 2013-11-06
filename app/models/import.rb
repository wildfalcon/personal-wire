class Import < ActiveRecord::Base

  # Associations
  belongs_to :photo
  belongs_to :source
  
  # Serializations
  # don't know yet if I want to seerialize this
  #serialize :key


  def import_photo!
    return if photo.present?
    photo_file, photo_name = source.get_photo_file_and_name(key)
    build_photo
    photo.photo = photo_file
    photo.photo.name = photo_name
    save
  end
end
