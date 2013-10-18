class Destination < ActiveRecord::Base
    belongs_to :destination_strategy, polymorphic: true
    
    delegate :destination_name, to: :destination_strategy
end
