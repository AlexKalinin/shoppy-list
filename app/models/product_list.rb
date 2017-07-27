class ProductList < ApplicationRecord
  has_and_belongs_to_many :products
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  validates :name, presence: true
  validates_uniqueness_of :name, :scope => :author_id

  scope :by_user, ->(user) { user.product_lists.order(:done, updated_at: :desc) }

  def self.name_taken(name, author)
    ProductList.where(name: name, author: author).any?
  end

  def sum
    # Rails.cache.fetch "product_list.#{self.id}.products_sum" do    # TODO: think about cache
      products.inject(0){|sum, p| sum + p.price * p.amount }.round 2
    # end
  end
end
