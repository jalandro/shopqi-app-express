require "#{ShopQiAppWebhook::Engine.models_dir}/shop"
require "#{ShopQiApp::Engine.models_dir}/shop" # methods: use_shopkit admin_url front_url
class Shop
  has_many :orders        , dependent: :destroy
  has_many :fulfillments  , through: :orders
  attr_accessible :shop_id, :name              , :shopqi_domain, :email


  def self.find_for_shopqi_oauth(data)
    shop_data = data.extra.raw_info.shop
    shop = where(shop_id: shop_data.id).first_or_create! name: shop_data.name, shopqi_domain: shop_data.shopqi_domain, email: shop_data.email
    shop.access_token = data.credentials.token
    shop.tap(&:save)
  end

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
      expire_fulfillments = shop.fulfillments.unreceived.expired
      ExpressMailer.notify(shop, expire_fulfillments).deliver unless expire_fulfillments.empty?
    end
  end
end
