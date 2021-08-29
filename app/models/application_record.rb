class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  has_one_attached :image
  has_one_attached :header
  has_one_attached :icon
end
