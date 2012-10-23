require "#{ShopQiAppWebhook::Engine.models_dir}/shop"
require "#{ShopQiApp::Engine.models_dir}/shop" # methods: use_shopkit admin_url front_url
class Shop
  has_many :orders
  has_many :fulfillments  , through: :orders
  attr_accessible :shop_id, :name           , :shopqi_domain

  def self.track # 跟踪物流
    self.find_in_batches(batch_size: 200).each do |shop|
      expire_orders = {} # 超期未到货
      shop.fulfillments.unreceived.each do |fulfillment|
        result = Express.search(fulfillment.tracking_number, fulfillment.tracking_company)
        if result.success?
          sign_item = result.data.last
          fulfillment.update_attributes received: true, received_at: Time.parse(sign_item['time'], receiver: sign_item['context'])
        elsif fulfillment.expire?
          expire_orders[fulfillment] = result
        end
      end
      # 发送邮件
      unless expire_orders.empty?

      end
    end
  end
end
