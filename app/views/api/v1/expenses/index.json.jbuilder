json.expenses @expenses do |expense|
  json.id expense.id
  json.sum expense.sum
  json.date expense.date
  json.description expense.description
  json.created_at expense.created_at
  json.updated_at expense.updated_at

  json.category expense.category.name
end
