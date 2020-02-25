json.incomes @incomes do |income|
  json.id income.id
  json.sum income.sum
  json.date income.date
  json.description income.description
  json.created_at income.created_at
  json.updated_at income.updated_at
  json.category_name income.category.name
end
