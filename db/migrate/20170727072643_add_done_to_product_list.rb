class AddDoneToProductList < ActiveRecord::Migration[5.1]
  def change
    add_column :product_lists, :done, :boolean, default: false
  end
end
