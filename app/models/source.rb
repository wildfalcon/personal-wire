class Source < ActiveRecord::Base
  
  # Scopes
  scope :enabled, -> { where(enabled: true) }
  scope :disabled, -> { where(enabled: false) }
  
  # Associations
  belongs_to :source_strategy, polymorphic: true, dependent: :destroy
  has_many :imports

  # Delegations
  delegate :source_name,    to: :source_strategy
  delegate :list_file_keys, to: :source_strategy
  delegate :get_photo_file, to: :source_strategy
  
  def build_imports!
    list_file_keys.each do |key|
      import = imports.find_or_create_by_key key
      import.save
    end
  end
  
  def import_photos!
    imports.each(&:import_photo!)
  end
  
    


end
