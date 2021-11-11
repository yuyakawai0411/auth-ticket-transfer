FactoryBot.define do
  factory :ticket do
    ticket_name     { Faker::Music::Hiphop.artist }
    event_date      { Faker::Date.between(from: '2023-09-23', to: '2023-10-25') }
    category_id     { Faker::Number.between(from: 1, to: 5) }
    status_id       { Faker::Number.between(from: 1, to: 3) }
    association :user, factory: :user
    association :event, factory: :event
  end
end