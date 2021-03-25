class Feedback < ApplicationRecord
  belongs_to :user
  belongs_to :product
  validates :title, presence: true, uniqueness: true, length: { minimum: 3,
                                                                too_short: "Enter minimum %{count} characters" }
  validates :content, presence: true, length: { maximum: 2000 }
end
