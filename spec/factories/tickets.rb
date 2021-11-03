FactoryBot.define do
  factory :ticket do
    ticket_name     { Faker::Music::Hiphop.artist }
    event_date      { Faker::Date.between(from: '2014-09-23', to: '2014-09-25') }
    category_id     { Faker::Number.between(from: 1, to: 5) }
    status_id       { Faker::Number.between(from: 1, to: 3) }
    association :user
  end
end