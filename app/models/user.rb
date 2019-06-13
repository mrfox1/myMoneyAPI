class User < ApplicationRecord
  has_secure_password
  has_secure_token

  has_many :expenses
  has_many :incomes

  validates :name, :email, :password, presence: true, on: :create
  validates :email, uniqueness: true, format: /@/
  validates :password, length: { minimum: 8 }, on: :create
end
