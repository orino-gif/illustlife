class Dtl < ApplicationRecord
  has_one :pst, dependent: :destroy
end
