class Creator < ApplicationRecord
  belongs_to :user, optional: true #optional:trueは外部キーを許可する設定
  has_one :performance , dependent: :destroy
  has_one :setting , dependent: :destroy

  # 新規ユーザー登録時に生成されるcreatorレコードと連動する
  mount_uploader :header, CreatorUploader
  mount_uploader :icon, CreatorUploader
end