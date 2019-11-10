class Category < ApplicationRecord
  CATEGORY_TYPES = %w{Expense Income}

  belongs_to :user

  has_many :incomes
  has_many :expenses

  validates :name, :record_type, presence: :true
end
