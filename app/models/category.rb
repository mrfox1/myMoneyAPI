class Category < ApplicationRecord
  CATEGORY_TYPES = %w{Expense Income}

  default_scope { order(:name) }

  belongs_to :user

  has_many :incomes, dependent: :destroy
  has_many :expenses, dependent: :destroy

  scope :by_type, -> (type) { where(record_type: type) }

  validates :name, :record_type, presence: :true
end
