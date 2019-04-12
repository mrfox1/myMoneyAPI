class Income < ApplicationRecord
  validates :sum, :date, presence: :true
end
