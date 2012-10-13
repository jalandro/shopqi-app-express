# encoding: UTF-8
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :fulfillment, :class => 'Fulfillments' do
    tracking_company "顺丰快递"
    tracking_number "123456"
  end
end
