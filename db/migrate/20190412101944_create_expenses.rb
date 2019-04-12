class CreateExpenses < ActiveRecord::Migration[6.0]
  def change
    create_table :expenses do |t|
      t.float :sum
      t.date :date
      t.text :description

      t.timestamps
    end
  end
end
