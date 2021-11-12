FactoryBot.define do
  factory :ticket do
    availabilty_date  { Faker::Date.between(from: '2018-09-23', to: '2023-10-25') }
    status_id         { Faker::Number.between(from: 1, to: 3) }
    association :user, factory: :user
    association :event, factory: :event
  end
end