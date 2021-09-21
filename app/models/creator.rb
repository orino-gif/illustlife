class Creator < ApplicationRecord
  belongs_to :user, optional: true #optional:trueは外部キーを許可する設定
  
  mount_uploader :header, CreatorUploader
  mount_uploader :icon, CreatorUploader
  mount_uploader :fg1, CreatorUploader
  mount_uploader :fg2, CreatorUploader
  mount_uploader :fg3, CreatorUploader
  mount_uploader :bg1, CreatorUploader
  mount_uploader :bg2, CreatorUploader
  mount_uploader :bg3, CreatorUploader
  mount_uploader :cg1, CreatorUploader
  mount_uploader :cg2, CreatorUploader
  mount_uploader :cg3, CreatorUploader
end

