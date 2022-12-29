class Ovr < ApplicationRecord
  belongs_to :expor, optional: true #optional:trueは外部キーを許可する設定
  mount_uploader :o_img, CreUploader
  validates :o_img, presence: true
end
