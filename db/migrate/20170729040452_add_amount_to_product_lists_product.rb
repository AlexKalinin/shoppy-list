class AddAmountToProductListsProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :product_lists_products, :amount, :integer, default: 1
    remove_column :products, :amount
  end
end
