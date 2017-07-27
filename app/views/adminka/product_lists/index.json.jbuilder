json.array! @product_lists do |list|
  json.id list.id
  json.name list.name
  json.products_number list.products.count
  json.products_sum -1
  json.done list.done
end
