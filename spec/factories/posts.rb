FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "タイトル#{n}" }
    sequence(:content) { |n| "本文#{n}" }
    event_url { Faker::Internet.url }
    association :user
    start_date { Date.today }
    end_date { Date.today + 7.days }
    prefecture_id { Prefecture.all.sample.id }
  end
end
