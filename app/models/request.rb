class Request < ApplicationRecord
    mount_uploader :deliver_img, CreatorUploader
    belongs_to :user
end
