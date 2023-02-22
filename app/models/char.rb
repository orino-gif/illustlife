class Char < ApplicationRecord
  belongs_to :thr, optional: true
  belongs_to :ttl, optional: true
end
