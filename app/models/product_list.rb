class ProductList < ApplicationRecord
  has_and_belongs_to_many :products
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  validates :name, presence: true
  validates_uniqueness_of :name, :scope => :author_id

  scope :by_user, ->(user) { user.product_lists.order('updated_at DESC') }

  def self.name_taken(name, author)
    ProductList.where(name: name, author: author).any?
  end
end
