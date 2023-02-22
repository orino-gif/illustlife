class Ttl < ApplicationRecord
  has_one :char, dependent: :destroy
  belongs_to :thr, optional: true
end
