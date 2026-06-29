import React from 'react'
import AppLayout from '@/Layouts/AppLayout'
import { LineChart, Line, BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, Area, AreaChart } from 'recharts'

type Summary = {
  total_revenue_cents: number
  revenue_mtd_cents: number
  growth_pct: number
  sales_count_mtd: number
}

type RecentSale = {
  id: number
  product_name: string
  buyer_email: string
  amount_cents: number
  currency: string
  created_at: string
}

type TopProduct = {
  id: number
  name: string
  revenue_cents: number
  sales_count: number
}

type DailyPoint = {
  date: string
  amount_cents: number
}

type DashboardProps = {
  summary: Summary
  recent_sales: RecentSale[]
  top_products: TopProduct[]
  daily_revenue: DailyPoint[]
}

function formatCurrency(cents: number) {
  return new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(cents / 100)
}

function formatDate(iso: string) {
  return new Date(iso).toLocaleDateString('en-US', { month: 'short', day: 'numeric' })
}

function shortDate(iso: string) {
  return new Date(iso).toLocaleDateString('en-US', { month: 'short', day: 'numeric' })
}

export default function Dashboard({ summary, recent_sales, top_products, daily_revenue }: DashboardProps) {
  return (
    <AppLayout>
      <div className="space-y-8">
        {/* Heading */}
        <div>
          <h1 className="text-2xl font-semibold tracking-tight">Dashboard</h1>
          <p className="mt-1 text-sm text-gray-600 dark:text-gray-400">
            Sales overview for <span className="font-medium">{recent_sales[0]?.buyer_email || 'your store'}</span>
          </p>
        </div>

        {/* Stat cards */}
        <div className="grid grid-cols-2 gap-4 sm:grid-cols-4">
          <StatCard label="Total revenue" value={formatCurrency(summary.total_revenue_cents)} />
          <StatCard label="Revenue (MTD)" value={formatCurrency(summary.revenue_mtd_cents)} />
          <StatCard label="Growth (MoM)" value={`${summary.growth_pct >= 0 ? '+' : ''}${summary.growth_pct.toFixed(1)}%`} tone={summary.growth_pct >= 0 ? 'positive' : 'negative'} />
          <StatCard label="Sales (MTD)" value={summary.sales_count_mtd.toString()} />
        </div>

        {/* Revenue line chart */}
        <section>
          <h2 className="mb-3 text-lg font-semibold">Revenue — last 7 days</h2>
          <div className="rounded-lg border border-gray-200 bg-white p-4 dark:border-gray-800 dark:bg-gray-900">
            <ResponsiveContainer width="100%" height={280}>
              <AreaChart data={daily_revenue} margin={{ top: 10, right: 20, left: 10, bottom: 5 }}>
                <defs>
                  <linearGradient id="colorAmount" x1="0" y1="0" x2="0" y2="1">
                    <stop offset="5%" stopColor="#FF90E8" stopOpacity={0.25} />
                    <stop offset="95%" stopColor="#FF90E8" stopOpacity={0} />
                  </linearGradient>
                </defs>
                <CartesianGrid strokeDasharray="3 3" stroke="#e5e7eb" />
                <XAxis dataKey="date" tickFormatter={shortDate} stroke="#9ca3af" fontSize={12} />
                <YAxis dataKey="amount_cents" tickFormatter={(v) => formatCurrency(v)} stroke="#9ca3af" fontSize={12} width={80} />
                <Tooltip formatter={(v: number) => formatCurrency(v)} labelFormatter={shortDate} />
                <Area type="monotone" dataKey="amount_cents" stroke="#FF90E8" fillOpacity={1} fill="url(#colorAmount)" />
              </AreaChart>
            </ResponsiveContainer>
          </div>
        </section>

        {/* Recent sales */}
        <section>
          <h2 className="mb-3 text-lg font-semibold">Recent sales</h2>
          <div className="overflow-x-auto rounded-lg border border-gray-200 dark:border-gray-800">
            <table className="min-w-full text-sm">
              <thead className="bg-gray-100/50 dark:bg-gray-800/30">
                <tr>
                  <th className="px-4 py-3 text-left font-medium">Product</th>
                  <th className="px-4 py-3 text-left font-medium">Buyer</th>
                  <th className="px-4 py-3 text-right font-medium">Amount</th>
                  <th className="px-4 py-3 text-right font-medium">Date</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-200 dark:divide-gray-800">
                {recent_sales.map((s) => (
                  <tr key={s.id} className="hover:bg-gray-50/50 dark:hover:bg-gray-800/40">
                    <td className="px-4 py-3 font-medium">{s.product_name}</td>
                    <td className="px-4 py-3 text-gray-600 dark:text-gray-400">{s.buyer_email}</td>
                    <td className="px-4 py-3 text-right font-mono text-sm">{formatCurrency(s.amount_cents)}</td>
                    <td className="px-4 py-3 text-right text-gray-500 dark:text-gray-400">{formatDate(s.created_at)}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </section>

        {/* Top products */}
        <section>
          <h2 className="mb-3 text-lg font-semibold">Top products</h2>
          <div className="grid grid-cols-1 gap-3 sm:grid-cols-2 lg:grid-cols-3">
            {top_products.map((p) => (
              <div key={p.id} className="rounded-lg border border-gray-200 bg-white p-4 dark:border-gray-800 dark:bg-gray-900">
                <div className="text-sm font-medium">{p.name}</div>
                <div className="mt-1 flex items-baseline justify-between">
                  <span className="font-mono text-lg">{formatCurrency(p.revenue_cents)}</span>
                  <span className="text-xs text-gray-500">{p.sales_count} sales</span>
                </div>
              </div>
            ))}
          </div>
        </section>
      </div>
    </AppLayout>
  )
}

function StatCard({ label, value, tone }: { label: string; value: string; tone?: 'positive' | 'negative' }) {
  const color = tone === 'positive' ? 'text-green-600' : tone === 'negative' ? 'text-red-500' : ''
  return (
    <div className="rounded-lg border border-gray-200 bg-white p-4 dark:border-gray-800 dark:bg-gray-900">
      <div className="text-xs uppercase tracking-wide text-gray-500">{label}</div>
      <div className={`mt-1 font-mono text-lg font-semibold ${color}`}>{value}</div>
    </div>
  )
}