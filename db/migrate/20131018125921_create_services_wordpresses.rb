class CreateServicesWordpresses < ActiveRecord::Migration
  def change
    create_table :servicess_wordpresses do |t|
      t.string :username
      t.string :password
      t.string :host

      t.timestamps
    end
  end
end
