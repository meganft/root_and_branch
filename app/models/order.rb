class Order < ApplicationRecord
  belongs_to :user
  belongs_to :status
  belongs_to :address
  has_many :order_items
  has_many :items, through: :order_items

  def order_total
    items.sum(:price)
  end

  def self.count_by_status
    group(:status).count
  end
end
