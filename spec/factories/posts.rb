FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "タイトル#{n}" }
    sequence(:content) { |n| "本文#{n}" }
    event_url { Faker::Internet.url }
    association :user
  end
end
