class Fulfillment < ActiveRecord::Base
  belongs_to :order
  has_many :trackings
  attr_accessible :fulfillment_id, :received, :receiver, :received_at, :tracking_company, :tracking_number, :created_at
  EXPIRE_NUM = 3

  scope :unreceived, where(received: false)

  scope :expired, lambda { where("created_at < ?", EXPIRE_NUM.days.ago) }

  def expire?
    self.created_at < EXPIRE_NUM.days.ago
  end
end
