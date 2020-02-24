json.categories do
  json.expenses_categories @categories.where(record_type: "Expense") do |category|
    json.id = category.id
    json.name = category.name
  end

  json.incomes_categories @categories.where(record_type: "Income") do |category|
    json.id = category.id
    json.name = category.name
  end
end
