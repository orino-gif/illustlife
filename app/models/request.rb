class Request < ApplicationRecord
  mount_uploader :deliver_img, CreatorUploader
  validates :message, length: {maximum: 1000}

end
