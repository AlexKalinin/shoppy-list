class ProductListsProduct < ApplicationRecord
  belongs_to :product
  belongs_to :product_list

  validates :product, :amount, :product_list, presence: true
end
