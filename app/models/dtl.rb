class Dtl < ApplicationRecord
  has_one :post, dependent: :destroy
end
