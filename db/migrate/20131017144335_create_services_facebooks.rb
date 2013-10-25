class CreateServicesFacebooks < ActiveRecord::Migration
  def change
    create_table :services_facebooks do |t|
      t.string :name
      t.string :uid
      t.string :token

      t.timestamps
    end
  end
end
