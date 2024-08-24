class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :content, length: { maximum: 65_535 }
  validates :event_url, length: { maximum: 255 }, format: { with: URI::regexp(%w[http https]), message: "無効なURLです", allow_blank: true }

  belongs_to :user
end
