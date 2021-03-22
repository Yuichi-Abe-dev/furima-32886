FactoryBot.define do
  factory :item_purchase do
    token { 'tok_abcdefghijk00000000000000000' }
    postal_code { '000-0000' }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    municipalities { Gimei.city.kanji }
    address_line1 { "#{Gimei.town.kanji}1-2-3" }
    address_line2 { Faker::Address.secondary_address }
    phone_number { Faker::Number.leading_zero_number(digits: 11) }
  end
end
