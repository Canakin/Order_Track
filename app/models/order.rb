class Order < ApplicationRecord
  belongs_to :customer
  has_many :products
  validates :employee_id, presence: true, numericality: { only_integer: true }
  validates :order_date, :require_date, :ship_postal_code, :ship_name, presence: true
  validates :ship_via, presence: true, numericality: { only_integer: true }
  validates :ship_adress, presence: true, length: { minimum: 10, too_short: "Enter minimum %{count} characters" }
  validates :ship_city, :shio_country, presence: true, confirmation: { case_sensitive: false }
  validates :orderid, :freight, presence: true, numericality: true
end
