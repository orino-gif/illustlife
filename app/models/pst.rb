class Pst < ApplicationRecord
  belongs_to :pass, optional: true
  belongs_to :dtl, optional: true
  belongs_to :tag, optional: true
  has_one :worth, dependent: :destroy
end
