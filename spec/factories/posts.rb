FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "タイトル#{n}" }
    sequence(:content) { |n| "本文#{n}" }
    event_url { Faker::Internet.url }
    association :user
    start_date { Date.today }
    end_date { Date.today + 7.days }
    prefecture_id { 14 }
    post_image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/example.jpg')) }
  end
end
