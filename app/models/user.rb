class User < ApplicationRecord
  has_secure_password
  has_secure_token

  validates :name, :email, :password, presence: true
  validates :email, uniqueness: true, format: /@/
  validates :password, length: { minimum: 8 }, on: :create
end
