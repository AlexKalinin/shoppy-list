json.array! @product_lists_products do |relation|
  product = relation.product

  json.id product.id
  json.name product.name
  json.description product.description
  json.amount relation.amount
  json.unit product.unit
  json.color product.color
  json.price product.price
end
