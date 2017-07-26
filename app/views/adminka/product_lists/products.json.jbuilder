json.array! @products do |product|
  json.id product.id
  json.description product.description
  json.amount product.amount
  json.unit product.unit
  json.color product.color
end
