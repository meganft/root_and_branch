class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  validates_confirmation_of :password

  has_many :orders

  enum role: [:default, :admin]


  def has_order(id)
    if orders.find(id)
      true
    end
  end
end
