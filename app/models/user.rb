class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # :recoverable, :trackable, :validatable, :registerable,
  devise :database_authenticatable, :rememberable

end
