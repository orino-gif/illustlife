class Creator < ApplicationRecord
  mount_uploader :header, CreatorUploader
  mount_uploader :icon, CreatorUploader
  belongs_to :user, optional: true #optional:trueは外部キーを許可する設定
end

