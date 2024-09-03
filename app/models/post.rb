class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :content, length: { maximum: 65_535 }
  validates :event_url, length: { maximum: 255 }, format: { with: URI.regexp(%w[http https]), message: "無効なURLです", allow_blank: true }

  belongs_to :user

  mount_uploader :post_image, PostImageUploader

  def self.ransackable_attributes(auth_object = nil)
    [ "title", "content", "start_date", "end_date", "created_at", "updated_at", "user_id" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "user" ]
  end
end
