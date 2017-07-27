class AddAuthorToProductListAndProducts < ActiveRecord::Migration[5.1]
  def change
    add_reference :products, :author, index: true, foreign_key: true
    add_reference :product_lists, :author, index: true, foreign_key: true
  end
end
