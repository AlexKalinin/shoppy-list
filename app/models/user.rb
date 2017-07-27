class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # :recoverable, :trackable, :validatable, :registerable,
  devise :database_authenticatable, :rememberable

  has_many :product_lists, foreign_key: 'author_id'
  has_many :products, foreign_key: 'author_id'
end
