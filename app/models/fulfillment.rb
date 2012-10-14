class Fulfillment < ActiveRecord::Base
  belongs_to :order
  attr_accessible :fulfillment_id, :received, :receiver, :tracking_company, :tracking_number, :created_at

  def expire?
    self.created_at < 3.days.ago
  end
end
