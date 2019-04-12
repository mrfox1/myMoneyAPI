class AddReferenceToExpenses < ActiveRecord::Migration[6.0]
  def change
    add_reference :expenses, :category, foreign_key: true
  end
end
