require "#{ShopQiAppWebhook::Engine.models_dir}/shop"
require "#{ShopQiApp::Engine.models_dir}/shop" # methods: use_shopkit admin_url front_url
class Shop
  has_many :orders
  has_many :fulfillments  , through: :orders
  attr_accessible :shop_id, :name           , :shopqi_domain

  def self.track # 跟踪物流
    self.all.each do |shop|
      shop.fulfillments.unreceived.each do |fulfillment|
        result = Express.search(fulfillment.tracking_number, fulfillment.tracking_company)
        result.data[fulfillment.trackings.size..result.data.size].each do |item|
          fulfillment.trackings.create! time: Time.parse(item['time']), context: item['context']
        end
        if result.success?
          sign_item = result.data.last
          fulfillment.update_attributes! received: true, received_at: Time.parse(sign_item['time']), receiver: sign_item['context']
        end
      end
    end
  end

  def self.send_mail
    self.all.each do |shop|
      shop.fulfillments.unreceived.expired.each do |fulfillment|

      end
    end
  end
end
