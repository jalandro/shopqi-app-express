# encoding: UTF-8
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    order_id 1
    name '#1001'
    customer_name '马海波'
    total_price 99.0
  end
end

