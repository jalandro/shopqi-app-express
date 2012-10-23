class Fulfillment < ActiveRecord::Base
  belongs_to :order
  has_many :trackings, dependent: :destroy, order: 'id asc'
  attr_accessible :fulfillment_id, :received, :receiver, :received_at, :tracking_company, :tracking_number, :created_at
  EXPIRE_NUM = 3

  scope :unreceived, where(received: false)

  scope :expired, lambda { where("created_at < ?", EXPIRE_NUM.days.ago) }

  def expire?
    self.created_at < EXPIRE_NUM.days.ago
  end

  def trackings_detail
    self.trackings.map{|t| "[#{t.id}]#{t.time.to_s(:short)} #{t.context}"}.join('<br/>')
  end
end
