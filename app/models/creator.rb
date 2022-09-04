class Creator < ApplicationRecord
  belongs_to :user, optional: true #optional:trueは外部キーを許可する設定
  
  # 新規ユーザー登録時に生成されるcreatorレコードと連動する
  mount_uploader :header, CreatorUploader
  mount_uploader :icon, CreatorUploader
  mount_uploader :chara_design, CreatorUploader
  mount_uploader :chara_design2, CreatorUploader
  mount_uploader :chara_design3, CreatorUploader

  validates :recommended_amount, presence: true,
    numericality: {only_integer: true, greater_than_or_equal_to: 1000}
  validates :minimum_amount, presence: true,
    numericality: {only_integer: true, greater_than_or_equal_to: 1000}
end