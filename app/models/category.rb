class Category < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :item_categories
  has_many :items, through: :item_categories

  after_save :set_slug

  def to_param
    slug
  end

  def set_slug
    slug = name.downcase.gsub(" ", "-")
  end
end
