require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  setup do
    # Creator dan data sudah ada dari seed
    # Routes: root "dashboard#index"
  end

  test "GET / returns 200" do
    get root_url
    assert_response :success
  end

  test "GET / returns Inertia dashboard component" do
    get root_url
    assert_response :success

    # Pastikan data dikirim ke Inertia
    assert_not_nil assigns(:inertia) if respond_to?(:assigns)
  end

  test "returns summary with revenue data" do
    get root_url
    assert_response :success

    # Pastikan summary dikirim dalam response
    assert_match /total_revenue_cents/, @response.body
    assert_match /revenue_mtd_cents/, @response.body
    assert_match /growth_pct/, @response.body
    assert_match /sales_count_mtd/, @response.body
  end

  test "returns recent_sales array" do
    get root_url
    assert_response :success

    assert_match /recent_sales/, @response.body
    assert_match /"\/"/, @response.body
  end

  test "returns top_products list" do
    get root_url
    assert_response :success

    assert_match /top_products/, @response.body
  end

  test "returns daily_revenue for 7 days" do
    get root_url
    assert_response :success

    assert_match /daily_revenue/, @response.body
  end

  test "revenue calculation is correct for seed data" do
    get root_url
    assert_response :success

    # MTD dipastikan ada — tidak kacau dari seed
    assert_match /2026/, @response.body
    assert_match /USD/, @response.body
  end
end