class Work < ApplicationRecord
  belongs_to :request, optional: true #optional:trueは外部キーを許可する設定
  mount_uploaders :images, CreatorUploader
end
