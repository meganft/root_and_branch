class Order < ApplicationRecord
  belongs_to :user
  belongs_to :status
  has_many :order_items
  has_many :items, through: :order_items

  def order_total
    items.sum(:price)
  end
end
