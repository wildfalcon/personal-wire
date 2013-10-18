class CreatePostings < ActiveRecord::Migration
  def change
    create_table :postings do |t|
      t.integer :photo_id
      t.integer :destination_id
      t.text :response

      t.timestamps
    end
  end
end
