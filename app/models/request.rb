class Request < ApplicationRecord
    mount_uploader :deliver_img, CreatorUploader
    validates :message,length: {maximum: 10}

end
