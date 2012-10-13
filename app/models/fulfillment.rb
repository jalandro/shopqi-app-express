class Fulfillment < ActiveRecord::Base
  belongs_to :order
  attr_accessible :fulfillment_id, :received, :receiver, :tracking_company, :tracking_number, :created_at
end
