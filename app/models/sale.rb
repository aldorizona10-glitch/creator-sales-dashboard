class Sale < ApplicationRecord
  belongs_to :creator
  belongs_to :product

  validates :amount_cents, numericality: { greater_than_or_equal_to: 0 }
  validates :currency, presence: true, length: { is: 3 }
end
