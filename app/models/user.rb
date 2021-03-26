class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :photo
  password_requirements = /\A
    (?=.{8,})
    (?=.*\d)
    (?=.*[a-z])
  /x
  validates :email, presence: true, uniqueness: true
  validates :password, format: password_requirements, on: :create
end
