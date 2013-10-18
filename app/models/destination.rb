class Destination < ActiveRecord::Base
    belongs_to :destination_strategy, polymorphic: true, dependent: :destroy
    
    delegate :destination_name, to: :destination_strategy
end
