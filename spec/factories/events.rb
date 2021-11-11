FactoryBot.define do
  factory :event do
    name   { Faker::Name.name }
    owner  { Faker::Name.name }
  end
end
