class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :photo_uid
      t.string :title
      t.string :caption

      t.timestamps
    end
  end
end
