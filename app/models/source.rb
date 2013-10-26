class Source < ActiveRecord::Base
  
  # Scopes
  scope :enabled, -> { where(enabled: true) }
  scope :disabled, -> { where(enabled: false) }
  

  belongs_to :source_strategy, polymorphic: true, dependent: :destroy

  # Delegations
  delegate :source_name, to: :source_strategy


end
