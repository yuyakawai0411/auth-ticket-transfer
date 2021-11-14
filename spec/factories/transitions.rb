FactoryBot.define do
  factory :transition do
    association :ticket, factory: :ticket
    association :sender, factory: :user
    association :receiver, factory: :user
  end
end
