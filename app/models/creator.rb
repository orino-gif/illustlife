class Creator < ApplicationRecord
  mount_uploader :header, AvatarUploader
  belongs_to :user, optional: true #optional:trueは外部キーを許可する設定
end

