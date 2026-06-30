require "test_helper"

class CreatorTest < ActiveSupport::TestCase
  test "validates presence of email" do
    creator = Creator.new(name: "Test", password: "password123", email: "")
    assert_not creator.valid?
    assert_includes creator.errors[:email], "can't be blank"
  end

  test "validates uniqueness of email" do
    creator = Creator.create!(name: "First", email: "unique@test.dev", password: "password123")
    duplicate = Creator.new(name: "Dup", email: "unique@test.dev", password: "password123")

    assert_not duplicate.valid?
    assert_includes duplicate.errors[:email], "has already been taken"
  end

  test "validates presence of name" do
    creator = Creator.new(email: "test@dev.dev", password: "password123", name: "")
    assert_not creator.valid?
    assert_includes creator.errors[:name], "can't be blank"
  end

  test "has_secure_password works" do
    creator = Creator.create!(name: "Test", email: "test-auth@dev.dev", password: "secure12345", password_confirmation: "secure12345")
    assert creator.authenticate("secure12345")
    assert_not creator.authenticate("wrong")
  end

  test "has many products" do
    creator = Creator.create!(name: "Test", email: "test-rel@dev.dev", password: "password123")
    assert_respond_to creator, :products
    assert_kind_of Product, creator.products.first
  end

  test "has many sales" do
    creator = Creator.create!(name: "Test", email: "test-rel2@dev.dev", password: "password123")
    assert_respond_to creator, :sales
    assert_kind_of Sale, creator.sales.first
  end
end