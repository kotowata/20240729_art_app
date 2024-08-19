FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    nick_name { Faker::Internet.username }
    email { Faker::Internet.unique.email }
    password { '12345678' }
    password_confirmation { '12345678' }
  end
end
