class Category < ApplicationRecord
  has_many :incomes
  has_many :expenses

  validates :name, :type, presence: :true
end
