# encoding: utf-8
class ExpressMailer < ActionMailer::Base
  default from: SecretSetting.author.email

  def notify(shop, fulfillments)
    @shop = shop
    @fulfillments = fulfillments

    mail to: shop.email, subject: "您的#{shop.name}商店存在超期未到货的订单"
  end
end
