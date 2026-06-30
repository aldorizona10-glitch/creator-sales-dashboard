import React from 'react'
import AppLayout from '@/Layouts/AppLayout'

type Product = {
  id: number
  name: string
  description: string | null
  price_cents: number
  created_at: string
}

export default function ProductsIndex({ products }: { products: Product[] }) {
  return (
    <AppLayout>
      <div className="space-y-6">
        <div className="flex items-center justify-between">
          <div>
            <h1 className="text-2xl font-semibold">Products</h1>
            <p className="mt-1 text-sm text-gray-600">{products.length} products</p>
          </div>
          <a href="/products/new" className="rounded-lg bg-pink-500 px-4 py-2 text-sm text-white hover:bg-pink-600">
            New product
          </a>
        </div>

        <div className="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {products.map((p) => (
            <a
              key={p.id}
              href={`/products/${p.id}`}
              className="rounded-lg border border-gray-200 bg-white p-4 hover:shadow-sm dark:border-gray-800 dark:bg-gray-900"
            >
              <div className="text-sm font-medium">{p.name}</div>
              {p.description && <div className="mt-1 text-xs text-gray-500">{p.description}</div>}
              <div className="mt-2 font-mono text-sm">
                ${(p.price_cents / 100).toFixed(2)}
              </div>
            </a>
          ))}
        </div>

        {products.length === 0 && (
          <p className="text-center text-sm text-gray-500">No products yet. <a href="/products/new" className="text-pink-500">Create one</a></p>
        )}
      </div>
    </AppLayout>
  )
}