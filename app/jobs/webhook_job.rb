# encoding: utf-8
class WebhookJob < Struct.new(:shop_id)

  def perform
    shop = Shop.find(shop_id)
    shop.use_shopkit
    Shopkit.create_webhook event: 'orders/fulfilled', callback_url: "http://#{SecretSetting.domain.host}/webhook"
    # 同步所有已发货的订单
    Shopkit.auto_traversal = true # 设置所有的分页记录
    Shopkit.orders(fulfillment_status: :fulfilled).reverse_each do |json|
      shop.orders.with json
    end
  end

end
