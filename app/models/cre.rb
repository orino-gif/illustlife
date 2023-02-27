class Cre < ApplicationRecord
  belongs_to :user, optional: true #optional:trueは外部キーを許可する設定
  has_one :pfm , dependent: :destroy
  has_one :sttg , dependent: :destroy
  # 新規ユーザー登録時に生成されるcreレコードと連動する
  mount_uploader :hdr, HdrUploader
  mount_uploader :icon, CreUploader
end