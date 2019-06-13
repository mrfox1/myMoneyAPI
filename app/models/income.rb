class Income < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :sum, :date, presence: :true
end
