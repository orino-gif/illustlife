class Char < ApplicationRecord
  belongs_to :path, optional: true
  belongs_to :ttl, optional: true
end
