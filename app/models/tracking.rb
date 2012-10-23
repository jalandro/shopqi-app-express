class Tracking < ActiveRecord::Base
  belongs_to :fulfillment
  attr_accessible :context, :time
end
