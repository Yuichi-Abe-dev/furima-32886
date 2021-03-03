FactoryBot.define do
  factory :item do
    name{Faker::String.random}
    description{Faker::Quote.yoda}
    category_id{Faker::Number.between(from: 2, to: 11)}
    condition_id{Faker::Number.between(from: 2, to: 7)}
    postage_id{Faker::Number.between(from: 2, to: 3)}
    prefecture_id{Faker::Number.between(from: 2, to: 48)}
    shipping_date_id{Faker::Number.between(from: 2, to: 4)}
    price{Faker::Number.between(from: 1, to: 1000000)}
    association :user
    after(:build) do |prototype|
      prototype.image.attach(io: File.open('public/images/400x400_01.png'), filename: '400x400_01.png')
    end
  end
end
