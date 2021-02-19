FactoryBot.define do
  factory :user do
    nickname { Faker::Name.last_name }
    email { Faker::Internet.free_email }
    last_name { Gimei.name.last.kanji }
    first_name { Gimei.name.first.kanji }
    last_name_kana { Gimei.name.last.katakana }
    first_name_kana { Gimei.name.first.katakana }
    password = Faker::Internet.password(min_length: 6)
    password { password }
    password_confirmation { password }
    birthday { Faker::Date.between(from: '1980-01-01', to: '2020-01-01') }
  end
end
