FactoryBot.define do
  factory :user do
    nickname {Faker::Name.last_name}
    email {Faker::Internet.free_email}
    password = Faker::Internet.password(min_length: 6)
    password {password}
    password_confirmation {password}
    last_name {Gimei.name.last.kanji}
    first_name {Gimei.name.first.kanji}
    last_name_kana {Gimei.name.last.katakana}
    first_name_kana {Gimei.name.last.hiragana}
    birthday {Faker::Date.between(from: '1990-01-01', to: '2021-01-01')}
  end
end