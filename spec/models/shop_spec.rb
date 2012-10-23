# encoding: UTF-8
require 'spec_helper'

describe Shop do

  let(:shop) { FactoryGirl.create :shop }

  let(:order) { FactoryGirl.create :order, shop: shop }

  let(:fulfillment) { FactoryGirl.create :fulfillment, order: order }

  let(:express_result) do
    {
      'status' => 2,
      'data' => [
        { 'time' => '2012-10-22 10:59', 'context' => '已收件' }
      ]
    }
  end

  context 'track' do

    before do
      fulfillment
      Express.stub(:search).and_return(Express::Result.new(express_result))
    end

    context 'trackings' do # 物流信息

      it "should be save" do
        expect do
          Shop.track
        end.to change(Tracking, :count).by(1)
      end

      it "should be add" do # 增量更新
        Shop.track
        express_result['status'] = '3'
        express_result['data'] << { 'time' => '2012-10-23 11:00', 'context' => '签收人: 马' }
        Express.stub(:search).and_return(Express::Result.new(express_result))
        expect do
          Shop.track
        end.to change(Tracking, :count).by(1)
      end

    end

    context 'fulfillment' do # 物流結果

      it "should be update" do
        express_result['status'] = '3'
        express_result['data'] << { 'time' => '2012-10-23 11:00', 'context' => '签收人: 马' }
        Express.stub(:search).and_return(Express::Result.new(express_result))
        Shop.track
        fulfillment.reload
        fulfillment.received.should be_true
        fulfillment.receiver.should eql '签收人: 马'
        fulfillment.received_at.should_not be_nil
      end
    end

  end

end

