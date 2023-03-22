class Pass < ApplicationRecord
  mount_uploader :way, CreUploader
  has_one :post, dependent: :destroy
end
