class AddSmallPhotoUidToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :small_photo_uid, :string
  end
end
