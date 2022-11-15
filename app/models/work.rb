class Work < ApplicationRecord
  belongs_to :request, optional: true #optional:trueは外部キーを許可する設定

  mount_uploader :img1, CreatorUploader
  mount_uploader :img2, CreatorUploader
  mount_uploader :img3, CreatorUploader
  mount_uploader :img3, CreatorUploader
  mount_uploader :img4, CreatorUploader
  mount_uploader :img5, CreatorUploader
  mount_uploader :img6, CreatorUploader
end
