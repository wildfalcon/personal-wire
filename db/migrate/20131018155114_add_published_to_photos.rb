class AddPublishedToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :published, :boolean, default: false
  end
end
