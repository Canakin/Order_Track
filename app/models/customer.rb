class Customer < ApplicationRecord
  has_many :orders
  validates :company_name, presence: { strict: true }, uniqueness: true, length: { minimum: 3 }
  validates :contact_title, presence: true, length: { minimum: 6 }
  validates :address, presence: true, length: { minimum: 10, too_short: "Enter minimum %{count} characters" }
  validates :city, presence: true, confirmation: { case_sensitive: false }
  validates :postal_code, presence: true, length: { minimum: 3 }
  validates :country, presence: true, confirmation: { case_sensitive: false }
  validates :phone, presence: true, uniqueness: true
  validates :fax, :customer_id, presence: true
  geocoded_by :city
  after_validation :geocode, if: :will_save_change_to_address?
end
