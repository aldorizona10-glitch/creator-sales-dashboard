class DashboardController < ApplicationController
  def index
    @current_creator = Creator.first
    sales = Sale.where(creator: @current_creator).order(created_at: :desc)

    month_start = Time.current.beginning_of_month
    prev_month_start = month_start - 1.month
    mtd_revenue = sales.where(created_at: month_start..).sum(:amount_cents)
    prev_mtd_revenue = sales.where(created_at: prev_month_start...month_start).sum(:amount_cents)
    growth = prev_mtd_revenue.positive? ? ((mtd_revenue - prev_mtd_revenue).to_f / prev_mtd_revenue) * 100 : 0

    # Daily revenue for last 7 days
    daily = (0..6).map do |i|
      day = Time.current - i.days
      actives = sales.where(created_at: day.beginning_of_day..day.end_of_day)
      { date: day.iso8601[0..9], amount_cents: actives.sum(:amount_cents) }
    end.reverse

    render inertia: "Dashboard", props: {
      summary: {
        total_revenue_cents: sales.sum(:amount_cents),
        revenue_mtd_cents: mtd_revenue,
        growth_pct: growth,
        sales_count_mtd: sales.where(created_at: month_start..).count,
      },
      recent_sales: sales.limit(10).map { |s| serialize_sale(s) },
      top_products: top_products(sales),
      daily_revenue: daily,
    }
  end

  private

  def serialize_sale(sale)
    {
      id: sale.id,
      product_name: sale.product.name,
      buyer_email: sale.buyer_email,
      amount_cents: sale.amount_cents,
      currency: sale.currency,
      created_at: sale.created_at.iso8601,
    }
  end

  def top_products(sales)
    sales
      .group(:product_id)
      .select("product_id, SUM(amount_cents) AS revenue_cents, COUNT(*) AS sales_count")
      .order(Arel.sql("SUM(amount_cents) DESC"))
      .limit(6)
      .map do |row|
        {
          id: row.product_id,
          name: Product.find(row.product_id).name,
          revenue_cents: row.revenue_cents.to_i,
          sales_count: row.sales_count.to_i,
        }
      end
  end
end