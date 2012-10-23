# encoding: utf-8
require "spec_helper"

describe ExpressMailer do

  describe "notify" do

    let(:shop) { FactoryGirl.create :shop }

    let(:order) { FactoryGirl.create :order, shop: shop }

    let(:fulfillment) { FactoryGirl.create :fulfillment, order: order }

    let(:mail) { ExpressMailer.notify(shop, [fulfillment]) }

    it "renders the headers" do
      mail.subject.should eq("您的测试商店商店存在超期未到货的订单")
      mail.to.should eq(["mahb45@gmail.com"])
    end

    it "renders the body" do
      body = mail.body.encoded
      body.should match(order.name)
      body.should match("#{fulfillment.tracking_company}.#{fulfillment.tracking_number}")
    end

  end

end
