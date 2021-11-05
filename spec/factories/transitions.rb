FactoryBot.define do
  factory :transition do
    association :ticket, factory: :ticket
    association :sender, factory: :user
    association :recever, factory: :user
  end
end
