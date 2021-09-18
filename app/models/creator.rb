class Creator < ApplicationRecord
  belongs_to :user, optional: true #optional:trueは外部キーを許可する設定
  
  mount_uploader :header, CreatorUploader
  mount_uploader :icon, CreatorUploader
  mount_uploader :deforume1, CreatorUploader
  mount_uploader :deforume2, CreatorUploader
  mount_uploader :deforume3, CreatorUploader
  mount_uploader :background1, CreatorUploader
  mount_uploader :background2, CreatorUploader
  mount_uploader :background3, CreatorUploader
  mount_uploader :foreground1, CreatorUploader
  mount_uploader :foreground2, CreatorUploader
  mount_uploader :foreground3, CreatorUploader
  mount_uploader :bustup1, CreatorUploader
  mount_uploader :bustup2, CreatorUploader
  mount_uploader :bustup3, CreatorUploader
  mount_uploader :rough1, CreatorUploader
  mount_uploader :rough2, CreatorUploader
  mount_uploader :rough3, CreatorUploader
  mount_uploader :slide1, CreatorUploader
  mount_uploader :slide2, CreatorUploader
  mount_uploader :slide3, CreatorUploader
  
end

