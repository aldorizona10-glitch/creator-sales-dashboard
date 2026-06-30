require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test "validates name presence" do
    creator = Creator.first
    product = Product.new(creator: creator, name: "", price_cents: 0)
    assert_not product.valid?
    assert_includes product.errors[:name], "can't be blank"
  end

  test "validates price_cents is non-negative" do
    creator = Creator.first
    product = Product.new(creator: creator, name: "Test", price_cents: -1)
    assert_not product.valid?
    assert_includes product.errors[:price_cents], "must be greater than or equal to 0"
  end

  test "accepts zero price" do
    creator = Creator.first
    product = Product.create!(creator: creator, name: "Free", price_cents: 0)
    assert product.valid?
    assert_equal 0, product.price_cents
  end

  test "belongs to creator" do
    creator = Creator.create!(name: "Test", email: "test-prod@dev.dev", password: "password123")
    product = Product.create!(creator: creator, name: "Test Product", price_cents: 1000)
    assert_respond_to product, :creator
    assert_kind_of Creator, product.creator
  end

  test "has many sales" do
    creator = Creator.create!(name: "Test", email: "test-prod2@dev.dev", password: "password123")
    product = Product.create!(creator: creator, name: "Test Product", price_cents: 1000)
    assert_respond_to product, :sales
    assert_kind_of Sale, product.sales.first
  end
end