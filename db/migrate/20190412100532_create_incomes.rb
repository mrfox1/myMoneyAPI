class CreateIncomes < ActiveRecord::Migration[6.0]
  def change
    create_table :incomes do |t|
      t.float :sum
      t.date :date
      t.text :description

      t.timestamps
    end
  end
end
