FactoryBot.define do
  factory :ticket do
    status_id       { Faker::Number.between(from: 1, to: 3) }
    association :user, factory: :user
    association :event, factory: :event
  end
end