class Product < ApplicationRecord
  enum color: { orange: 0, gray: 1, red: 2, green: 3, blue: 4 }
  enum units: { kg: 0, pieces: 1, liter: 2}

  has_and_belongs_to_many :product_lists
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  validates :name, :amount, :unit, presence: true
  validates :description, presence: true, length: { maximum: 150 }

  scope :excluded_by_ids, (lambda do |product_ids|
    where('id NOT IN (?)', product_ids) if product_ids.is_a?(Array) && product_ids.any? # avoiding of zero zet division
  end)

  def self.names
    Product.all.each_with_object([]) { |product, list| list << product.name }.join(',')
  end

  def self.name_taken(name, author)
    Product.where(name: name, author: author).any?
  end
end
