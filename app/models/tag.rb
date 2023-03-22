class Tag < ApplicationRecord
  has_one :pst, dependent: :destroy
end
