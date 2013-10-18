class CreateDestinations < ActiveRecord::Migration
  def change
    create_table :destinations do |t|
      t.references :destination_strategy, polymorphic: true
      t.boolean :enabled, :default => false

      t.timestamps
    end
  end
end
