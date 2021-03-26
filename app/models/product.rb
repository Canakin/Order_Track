class Product < ApplicationRecord
  belongs_to :order
  has_many :feedbacks, dependent: :destroy
  validates :quantity, :productid, presence: true, numericality: { only_integer: true }
  validates :discount, presence: true, numericality: { less_than_or_equal_to: 1 }
  validates :unit_price, presence: true, numericality: true
end
