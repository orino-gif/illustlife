class Request < ApplicationRecord
    mount_uploader :deliver_img, CreatorUploader
end
