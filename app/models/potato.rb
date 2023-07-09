class Potato < ApplicationRecord

  validates :time, presence: true, uniqueness: true
  validates :value, presence: true

end