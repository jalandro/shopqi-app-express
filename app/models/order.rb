class Order < ActiveRecord::Base
  belongs_to :shop
  has_many :fulfillments, dependent: :destroy
  attr_accessible :name , :order_id          , :customer_name, :total_price

  def admin_url
    "#{shop.admin_url}/orders/#{order_id}"
  end

  def self.with(json)
    fulfillments = json['fulfillments']
    fulfilled = (!fulfillments.nil? and fulfillments.map{|f| !f['tracking_company'].blank? and !f['tracking_number'].blank?}.any?)
    return unless fulfilled
    order = self.where(order_id: json['id']).first_or_create!(order_id: json['id'], name: json['name'], customer_name: json['customer']['name'], total_price: json['total_price'])
    json['fulfillments'].each do |fulfillment|
      order.fulfillments.where(fulfillment_id: fulfillment['id']).first_or_create! fulfillment_id: fulfillment['id'], tracking_company: fulfillment['tracking_company'], tracking_number: fulfillment['tracking_number']
    end
    order
  end
end
