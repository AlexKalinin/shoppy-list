class AddIdToProductListsProducts < ActiveRecord::Migration[5.1]
  def up
    # In this example
    #
    #   ProductListsProduct.find_by(product_id: p_id, product_list_id: pl_id).update_attribute(:amount, amount)
    #
    # Rails can't update `product_lists_products` table because it hasn't primary key `id`
    # I could make data migration instead of dropping and creating table. But I have no production data yet (only seeds),
    # so I can do this faster.

    drop_table :product_lists_products

    create_table 'product_lists_products' do |t|
      t.integer 'amount', default: 1
      t.references :product, index: true
      t.references :product_list, index: true
    end
  end
end
