require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  setup do
    Sale.delete_all
    Product.delete_all
    Creator.delete_all

    @creator = Creator.create!(name: "Dashboard Creator", email: "dashboard@example.org", password: "password123")
    @product = Product.create!(creator: @creator, name: "Course", price_cents: 12_000)
    @sale = Sale.create!(
      creator: @creator,
      product: @product,
      amount_cents: 12_000,
      buyer_email: "buyer@example.org",
      created_at: Time.current
    )
  end

  test "GET / returns 200" do
    get root_url
    assert_response :success
  end

  test "GET / returns Inertia dashboard component" do
    get root_url
    assert_response :success

    assert_equal "Dashboard", inertia_page.fetch("component")
  end

  test "returns summary with revenue data" do
    get root_url
    assert_response :success

    summary = inertia_page.dig("props", "summary")
    assert_equal 12_000, summary.fetch("total_revenue_cents")
    assert_equal 12_000, summary.fetch("revenue_mtd_cents")
    assert_equal 0, summary.fetch("growth_pct")
    assert_equal 1, summary.fetch("sales_count_mtd")
  end

  test "returns recent_sales array" do
    get root_url
    assert_response :success

    recent_sales = inertia_page.dig("props", "recent_sales")
    assert_equal 1, recent_sales.length
    assert_equal @sale.id, recent_sales.first.fetch("id")
    assert_equal "Course", recent_sales.first.fetch("product_name")
  end

  test "returns top_products list" do
    get root_url
    assert_response :success

    top_products = inertia_page.dig("props", "top_products")
    assert_equal 1, top_products.length
    assert_equal @product.id, top_products.first.fetch("id")
    assert_equal 12_000, top_products.first.fetch("revenue_cents")
  end

  test "returns daily_revenue for 7 days" do
    get root_url
    assert_response :success

    daily_revenue = inertia_page.dig("props", "daily_revenue")
    assert_equal 7, daily_revenue.length
    assert daily_revenue.any? { |day| day.fetch("amount_cents") == 12_000 }
  end

  test "revenue calculation is based on current creator sales" do
    get root_url
    assert_response :success

    props = inertia_page.fetch("props")
    assert_equal 12_000, props.dig("summary", "total_revenue_cents")
    assert_equal "USD", props.dig("recent_sales", 0, "currency")
  end

  private

  def inertia_page
    match = @response.body.match(%r{<script data-page="app" type="application/json">(.*?)</script>}m)
    assert match, "expected Inertia page payload"

    JSON.parse(match[1])
  end
end
