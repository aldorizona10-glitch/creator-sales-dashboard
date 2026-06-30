require "test_helper"

class SaleTest < ActiveSupport::TestCase
  test "validates amount_cents is non-negative" do
    creator = Creator.first
    product = Product.first
    sale = Sale.new(creator: creator, product: product, amount_cents: -1, buyer_email: "test@test.dev")
    assert_not sale.valid?
    assert_includes sale.errors[:amount_cents], "must be greater than or equal to 0"
  end

  test "accepts zero amount" do
    creator = Creator.create!(name: "Test", email: "test-zero@dev.dev", password: "password123")
    product = Product.create!(creator: creator, name: "Test", price_cents: 1000)
    sale = Sale.new(creator: creator, product: product, amount_cents: 0, buyer_email: "test@test.dev")
    assert_not sale.valid?, "amount_cents should be > 0"
    assert_includes sale.errors[:amount_cents], "must be greater than or equal to 0"
  end

  test "belongs to creator" do
    creator = Creator.create!(name: "Test", email: "test-sale@dev.dev", password: "password123")
    product = Product.create!(creator: creator, name: "Test", price_cents: 1000)
    sale = Sale.create!(creator: creator, product: product, amount_cents: 100, buyer_email: "test@test.dev")
    assert_respond_to sale, :creator
    assert_kind_of Creator, sale.creator
  end

  test "belongs to product" do
    creator = Creator.create!(name: "Test", email: "test-sale2@dev.dev", password: "password123")
    product = Product.create!(creator: creator, name: "Test", price_cents: 1000)
    sale = Sale.create!(creator: creator, product: product, amount_cents: 100, buyer_email: "test@test.dev")
    assert_respond_to sale, :product
    assert_kind_of Product, sale.product
  end

  test "validates currency is 3 chars" do
    creator = Creator.first
    product = Product.first
    sale = Sale.new(creator: creator, product: product, amount_cents: 100, buyer_email: "test@test.dev", currency: "US")
    assert_not sale.valid?
    assert_includes sale.errors[:currency], "is the wrong length (should be 3 characters)"
  end

  test "default currency is USD" do
    sale = Sale.new(creator: Creator.first, product: Product.first, amount_cents: 100, buyer_email: "test@test.dev")
    assert_equal "USD", sale.currency
  end
end