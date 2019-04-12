class Expense < ApplicationRecord
  validates :sum, :date, presence: :true
end
