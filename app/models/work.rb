class Work < ApplicationRecord
  belongs_to :req, optional: true #optional:trueは外部キーを許可する設定
  mount_uploaders :images, DownUploader
end
