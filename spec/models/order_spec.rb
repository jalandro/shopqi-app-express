# encoding: UTF-8
require 'spec_helper'

describe Order do

  let(:shop) { FactoryGirl.create :shop }

  let(:json){
    {
      cancel_reason: nil,
      cancelled_at: nil,
      closed_at: "2012-05-15T21:36:38+08:00",
      created_at: "2012-04-16T23:07:33+08:00",
      customer_id: 2,
      email: "mahb45@gmail.com",
      financial_status: "pending",
      fulfillment_status: "fulfilled",
      id: 99,
      name: "#1095",
      note: "",
      number: 95,
      order_number: 1095,
      payment_id: 8,
      shipping_rate: "普通快递-0",
      shop_id: 2,
      status: "closed",
      subtotal_price: 45.0,
      token: "96b1d0806a03012f21f6480aa969d9a6",
      total_line_items_price: 45.0,
      total_price: 45.0,
      trade_no: nil,
      updated_at: "2012-05-15T21:36:38+08:00",
      fulfillments: [ {id: 1, created_at: '2012-10-13T20:52:45+08:00'}.stringify_keys ],
      customer: {id: 1, name: '马海波'}.stringify_keys
    }.stringify_keys!
  }

  context '#with' do

    context 'without fulfillments' do # 没有物流信息

      it 'should be ignore' do
        expect do
          expect do
            order = shop.orders.with json
          end.to_not change(Order, :count)
        end.to_not change(Fulfillment, :count)
      end

    end

    context 'with fulfillments' do # 有物流信息

      before do
        json['fulfillments'].first.merge! 'tracking_company' => '顺丰快递', 'tracking_number' => '123456'
      end

      it 'should be create', f: true do
        expect do
          expect do
            shop.orders.with json
          end.to change(Order, :count).by(1)
        end.to change(Fulfillment, :count).by(1)
      end

    end

  end

end
