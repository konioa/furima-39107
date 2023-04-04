FactoryBot.define do
  factory :order_payment do
    postcode { '123-4567' }
    prefecture_id  { 2 }
    city { '東京都' }
    block { '1-1' }
    building { '東京ハイツ' }
    phone { '08011111111' }
  end
end
