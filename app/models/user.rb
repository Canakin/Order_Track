class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :photo
  password_requirements = /\A
    (?=.{8,})
    (?=.*\d)
    (?=.*[a-z])
  /x
  validates :password, format: password_requirements
end
