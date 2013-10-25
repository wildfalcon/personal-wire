class CreateSourcesDropboxes < ActiveRecord::Migration
  def change
    create_table :sources_dropboxes do |t|
      t.integer :uid
      t.string :token
      t.string :path

      t.timestamps
    end
  end
end
