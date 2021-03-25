class Product < ApplicationRecord
  belongs_to :order
  has_many :feedbacks, dependent: :destroy
  validates :unit_price, presence: true, numericality: true
  validates :quantity, presence: true, numericality: { only_integer: true }
  validates :discount, presence: true, numericality: { less_than_or_equal_to: 1 }
  validates :productid, presence: true, uniqueness: true, numericality: { only_integer: true }
end
