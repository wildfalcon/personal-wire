class CreateDestinationsFacebookPages < ActiveRecord::Migration
  def change
    create_table :destinations_facebook_pages do |t|
      t.string :name
      t.string :uid
      t.string :token

      t.timestamps
    end
  end
end
