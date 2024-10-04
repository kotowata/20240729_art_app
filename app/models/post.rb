class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }
  validates :content, length: { maximum: 140 }
  validates :event_url, length: { maximum: 255 }, format: { with: URI.regexp(%w[http https]), message: "無効なURLです", allow_blank: true }

  belongs_to :user
  has_many :likeks, dependent: :destroy

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture, class_name: "Prefecture"

  mount_uploader :post_image, PostImageUploader

  def self.ransackable_attributes(auth_object = nil)
    [ "title", "content" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "user" ]
  end
end
