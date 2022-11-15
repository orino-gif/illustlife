class Request < ApplicationRecord
  has_one :work , dependent: :destroy

  validates :msg, length: {maximum: 700}
end
