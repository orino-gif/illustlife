class Exposure < ApplicationRecord
  mount_uploader :exposed_img, CreatorUploader
end
