FactoryBot.define do
  factory :event do
    name   { Faker::Music::Hiphop.artist  }
    owner  { Faker::Name.name }
    date      { Faker::Date.between(from: '2018-09-23', to: '2023-10-25') }
    category_id     { Faker::Number.between(from: 1, to: 5) }
  end
end
