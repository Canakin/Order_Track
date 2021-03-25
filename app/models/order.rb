class Order < ApplicationRecord
  belongs_to :customer
  has_many :products
  validates :employee_id, presence: true, numericality: { only_integer: true }
  validates :order_date, :require_date, :ship_postal_code, presence: true
  validates :ship_via, presence: true, numericality: { only_integer: true }
  validates :freight, presence: true, numericality: true
  validates :ship_name, presence: true, uniqueness: true
  validates :ship_adress, presence: true, length: { minimum: 10, too_short: "Enter minimum %{count} characters" }
  validates :ship_city, presence: true, confirmation: { case_sensitive: false }
  validates :shio_country, presence: true, confirmation: { case_sensitive: false }
  validates :orderid, presence: true, numericality: true
end
