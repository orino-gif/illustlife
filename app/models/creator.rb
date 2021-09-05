class Creator < ApplicationRecord
  mount_uploader :header, CreatorUploader
  mount_uploader :icon, CreatorUploader
  mount_uploader :deforume1, CreatorUploader
  mount_uploader :deforume2, CreatorUploader
  mount_uploader :deforume3, CreatorUploader
  belongs_to :user, optional: true #optional:trueは外部キーを許可する設定
end

