class Creator < ApplicationRecord
  has_secure_password

  has_many :products, dependent: :destroy
  has_many :sales, dependent: :destroy

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true
end
