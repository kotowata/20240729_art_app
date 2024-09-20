FactoryBot.define do
  factory :user do
    nick_name { Faker::Internet.username }
    email { Faker::Internet.unique.email }
    password { '12345678' }
    password_confirmation { '12345678' }
  end
end
