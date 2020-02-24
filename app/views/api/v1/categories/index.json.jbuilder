json.categories do
  json.expenses_categories @categories.where(type: "Expense") do |category|
    json.id = category.id
    json.name = category.name
  end

  json.incomes_categories @categories.where(type: "Income") do |category|
    json.id = category.id
    json.name = category.name
  end
end
