class Ttl < ApplicationRecord
  has_one :char, dependent: :destroy
  belongs_to :path, optional: true
end
