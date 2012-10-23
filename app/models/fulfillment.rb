class Fulfillment < ActiveRecord::Base
  belongs_to :order
  attr_accessible :fulfillment_id, :received, :receiver, :received_at, :tracking_company, :tracking_number, :created_at

  scope :unreceived, where(received: false)

  def expire?
    self.created_at < 3.days.ago
  end
end
