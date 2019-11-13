class User < ApplicationRecord
  VALID_EMAIL_REG = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_secure_password
  has_secure_token

  has_many :categories
  has_many :expenses
  has_many :incomes

  validates :name, :email, :password, presence: true, on: :create
  validates :email, uniqueness: true, format: { with: VALID_EMAIL_REG }
  validates :password, length: { minimum: 8 }, on: :create
end
