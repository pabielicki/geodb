FactoryBot.define do
  factory :datum do
    ip { Faker::Internet.public_ip_v4_address }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
  end
end
