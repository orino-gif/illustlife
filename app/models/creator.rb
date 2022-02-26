class Creator < ApplicationRecord
  belongs_to :user, optional: true #optional:trueは外部キーを許可する設定
  
  mount_uploader :header, CreatorUploader
  mount_uploader :icon, CreatorUploader
end

