class Pass < ApplicationRecord
  mount_uploader :way, CreUploader
  has_one :pst, dependent: :destroy
end
