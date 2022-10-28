class Creator < ApplicationRecord
  belongs_to :user, optional: true #optional:trueは外部キーを許可する設定
  has_one :performance , dependent: :destroy

  # 新規ユーザー登録時に生成されるcreatorレコードと連動する
  mount_uploader :header, CreatorUploader
  mount_uploader :icon, CreatorUploader

  # 推奨金額入力値が1000以上の数字のみ。空でないこと。
  validates :recommend, presence: true,
    numericality: {only_integer: true, greater_than_or_equal_to: 1000}
    
  # 最小金額入力値が1000以上の数字のみ。空でないこと。
  validates :minimum, presence: true,
    numericality: {only_integer: true, greater_than_or_equal_to: 1000}
end