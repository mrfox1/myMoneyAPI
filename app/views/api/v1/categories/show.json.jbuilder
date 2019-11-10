json.category do
  json.id @category.id
  json.name @category.name
  json.type @category.record_type

  json.recodrs @records do |record|
    json.id = record.id
    json.date = record.date
    json.sum = record.sum
    json.description = record.description
  end
end