FactoryBot.define do
  factory :item do
    title              {'ああああ'}
    description        {'ああああああああ'}
    category_id        {'2'}
    condition_id       {'2'}
    delivery_cost_id   {'2'}
    prefecture_id      {'2'}
    shipping_date_id   {'2'}
    price              {'100000'}
    association :user   

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.jpg'), filename: 'test_image.jpg')
    end
  end
end
