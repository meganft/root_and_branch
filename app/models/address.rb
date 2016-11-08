class Address < ApplicationRecord
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  
  belongs_to :user
  has_many :orders
end
