class Tag < ApplicationRecord
  has_one :post, dependent: :destroy
end