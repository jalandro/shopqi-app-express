# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tracking, :class => 'Trackings' do
    fulfillment nil
    time ""
    context "MyString"
  end
end
