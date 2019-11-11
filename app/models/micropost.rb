class Micropost < ApplicationRecord
  belongs_to :user
  scope :order_desc, ->{order created_at: :desc}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.max_micropost}
  validate  :picture_size

  private

  def picture_size
    errors.add(:picture, I18n.t(".max_pic")) if picture.size > 5.megabytes
  end
end
