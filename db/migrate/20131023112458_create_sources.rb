class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.references :source_strategy, polymorphic: true
      t.boolean :enabled

      t.timestamps
    end
  end
end
