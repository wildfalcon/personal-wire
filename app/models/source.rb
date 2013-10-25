class Source < ActiveRecord::Base

  belongs_to :source_strategy, polymorphic: true, dependent: :destroy

end
