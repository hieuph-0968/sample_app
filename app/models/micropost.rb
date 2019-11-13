class Micropost < ApplicationRecord
  belongs_to :user
  default_scope ->{order created_at: :desc}
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.max_micropost}
end
