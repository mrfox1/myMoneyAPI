class Expense < ApplicationRecord
  belongs_to :category

  validates :sum, :date, presence: :true
end
