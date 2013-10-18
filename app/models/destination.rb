class Destination < ActiveRecord::Base
    belongs_to :destination_strategy, polymorphic: true, dependent: :destroy
    
    delegate :destination_name, to: :destination_strategy
  # Scopes
  scope :enabled, -> { where(enabled: true) }
  scope :disabled, -> { where(enabled: false) }
end
