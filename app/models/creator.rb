class Creator < ApplicationRecord
  belongs_to :user, optional: true #optional:trueは外部キーを許可する設定
  
  mount_uploader :header, CreatorUploader
  mount_uploader :icon, CreatorUploader

  validates :recommended_amount, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1000}
  validates :minimum_amount, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1000}
end

