if Rails.env.development?
  user = User.create! email: 'example@domain.com', password: '123456789'

  products = {
    масло_подсолнечное: Product.create!(name: 'масло подсолнечное', unit: 'liter', color: 'orange', price: 195, description: 'масло подсолнечное', author: user),
    чеснок:             Product.create!(name: 'чеснок', unit: 'kg', color: 'orange', price: 250, description: 'обычный чеснок', author: user),
    капуста:            Product.create!(name: 'капуста', unit: 'kg', color: 'orange', price: 25, description: 'обычная капуста', author: user),
    морковь:            Product.create!(name: 'морковь', unit: 'kg', color: 'orange', price: 10, description: 'овощ такой', author: user),
    фасоль:             Product.create!(name: 'фасоль', unit: 'kg', color: 'orange', price: 10, description: 'растет в стрючках на огороде', author: user),
    укроп:              Product.create!(name: 'укроп', unit: 'pieces', color: 'orange', price: 3, description: 'растение, на огороде можно найти', author: user),
    картофель:          Product.create!(name: 'картофель', unit: 'kg', color: 'orange', price: 56, description: 'выкапывают по осени из земли', author: user),
    брынза:             Product.create!(name: 'брынза', unit: 'pieces', color: 'orange', price: 250, description: 'соленая брынза', author: user),
    огурцы:             Product.create!(name: 'огурцы', unit: 'kg', color: 'orange', price: 25, description: 'соленая брынза', author: user),
    листья_салата:      Product.create!(name: 'листья_салата', unit: 'pieces', color: 'orange', price: 5, description: 'Зеленые листья салата', author: user),
    помидоры:           Product.create!(name: 'помидоры', unit: 'kg', color: 'orange', price: 25, description: 'Обычные помидоры', author: user),
    лимон:              Product.create!(name: 'помидоры', unit: 'pieces', color: 'orange', price: 50, description: 'Лимон тонкокорый', author: user),
  }
  product_lists = [
    begin
      pl = ProductList.create!(name: 'На варку борща!', author: user)
      ProductListsProduct.create!(product_list: pl, product: products[:масло_подсолнечное], amount: 1)
      ProductListsProduct.create!(product_list: pl, product: products[:капуста], amount: 1)
      ProductListsProduct.create!(product_list: pl, product: products[:фасоль], amount: 1)
      ProductListsProduct.create!(product_list: pl, product: products[:укроп], amount: 2)
      ProductListsProduct.create!(product_list: pl, product: products[:картофель], amount: 1)
      pl
    end,

    begin
      pl = ProductList.create!(name: 'На салат "Греческий"', author: user)
      ProductListsProduct.create!(product_list: pl, product: products[:масло_подсолнечное], amount: 1)
      ProductListsProduct.create!(product_list: pl, product: products[:брынза], amount: 2)
      ProductListsProduct.create!(product_list: pl, product: products[:листья_салата], amount: 4)
      ProductListsProduct.create!(product_list: pl, product: products[:помидоры], amount: 2)
      ProductListsProduct.create!(product_list: pl, product: products[:огурцы], amount: 1)
      ProductListsProduct.create!(product_list: pl, product: products[:лимон], amount: 2)
      pl
    end
  ]
end