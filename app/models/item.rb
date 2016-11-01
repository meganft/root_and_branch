class Item < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :image, presence: true

  has_many :item_categories
  has_many :categories, through: :items_categories
end
