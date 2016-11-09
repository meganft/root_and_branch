class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  validates_confirmation_of :password

  has_many :orders
  has_many :addresses

  enum role: [:default, :admin]

  def has_order(id)
    if orders.all.include?(Order.find(id))
      true
    else
      false
    end
  end
end
