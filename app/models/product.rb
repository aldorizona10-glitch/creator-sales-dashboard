class Product < ApplicationRecord
  belongs_to :creator
  has_many :sales, dependent: :destroy

  validates :name, presence: true
  validates :price_cents, numericality: { greater_than_or_equal_to: 0 }
end
