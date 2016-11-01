class Category < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :item_categories
  has_many :items, through: :item_categories
end
