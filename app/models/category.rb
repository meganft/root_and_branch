class Category < ApplicationRecord
  attr_accessor :name, :slug
  
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :item_categories
  has_many :items, through: :item_categories

  validates :slug, presence: true

  def to_param
    slug
  end
end
