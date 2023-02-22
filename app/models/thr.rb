class Thr < ApplicationRecord
  has_one :char, dependent: :destroy
  has_one :ttl, dependent: :destroy
  mount_uploader :img, CreUploader
end
