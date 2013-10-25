class CreateServicesDropboxes < ActiveRecord::Migration
  def change
    create_table :services_dropboxes do |t|
      t.integer :uid
      t.string :token
      t.string :path

      t.timestamps
    end
  end
end
