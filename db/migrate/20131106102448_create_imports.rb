class CreateImports < ActiveRecord::Migration
  def change
    create_table :imports do |t|
      t.integer :photo_id
      t.integer :source_id
      t.text :key

      t.timestamps
    end
  end
end
