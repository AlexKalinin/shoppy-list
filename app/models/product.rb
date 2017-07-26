class Product < ApplicationRecord
  enum color: { white: 0, black: 1, red: 2, green: 3, blue: 4 }
  enum units: { kg: 0, pieces: 1, liter: 2}

  has_and_belongs_to_many :product_lists

  validates :name, :amount, :unit, presence: true
  validates :description, presence: true, length: { maximum: 150 }

  def self.names
    Product.all.each_with_object([]) { |product, list| list << product.name }.join(',')
  end
end
