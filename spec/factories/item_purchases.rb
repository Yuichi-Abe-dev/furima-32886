FactoryBot.define do
  factory :item_purchase do
    token { 'tok_abcdefghijk00000000000000000' }
    postal_code { "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}" }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    municipalities { Gimei.city.kanji }
    address_line1 { "#{Gimei.town.kanji}1-2-3" }
    address_line2 { Faker::Address.secondary_address }
    phone_number { '00011112222' }
  end
end
