class Category < ApplicationRecord
  has_many :incomes
  has_many :expenses

  validates :name, :record_type, presence: :true
end
