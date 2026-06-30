import React, { useState } from 'react'
import AppLayout from '@/Layouts/AppLayout'

type Props = {
  product?: {
    id: number
    name: string
    description: string | null
    price_cents: number
  } | null
}

export default function ProductForm({ product }: Props) {
  const isEditing = !!product
  const [name, setName] = useState(product?.name ?? '')
  const [description, setDescription] = useState(product?.description ?? '')
  const [priceCents, setPriceCents] = useState(product?.price_cents?.toString() ?? '')

  return (
    <AppLayout>
      <div className="mx-auto max-w-md space-y-6">
        <div>
          <h1 className="text-2xl font-semibold">{isEditing ? 'Edit product' : 'New product'}</h1>
          <p className="mt-1 text-sm text-gray-600">
            {isEditing ? 'Update your product details' : 'Add a new product to your store'}
          </p>
        </div>

        <form
          method="post"
          action={isEditing ? `/products/${product!.id}` : '/products'}
          className="space-y-4"
        >
          {isEditing && <input type="hidden" name="_method" value="patch" />}

          <div>
            <label htmlFor="name" className="mb-1 block text-sm font-medium">Name</label>
            <input id="name" type="text" name="name" value={name} onChange={(e) => setName(e.target.value)}
              className="w-full rounded-lg border border-gray-300 px-3 py-2 text-sm focus:border-pink-500 focus:outline-none" required />
          </div>

          <div>
            <label htmlFor="description" className="mb-1 block text-sm font-medium">Description</label>
            <textarea id="description" name="description" value={description} onChange={(e) => setDescription(e.target.value)}
              className="w-full rounded-lg border border-gray-300 px-3 py-2 text-sm focus:border-pink-500 focus:outline-none" rows={3} />
          </div>

          <div>
            <label htmlFor="price_cents" className="mb-1 block text-sm font-medium">Price (cents)</label>
            <input id="price_cents" type="number" name="price_cents" value={priceCents} onChange={(e) => setPriceCents(e.target.value)}
              className="w-full rounded-lg border border-gray-300 px-3 py-2 text-sm focus:border-pink-500 focus:outline-none" min="0" required />
          </div>

          <div className="flex gap-3">
            <button type="submit" className="flex-1 rounded-lg bg-pink-500 px-4 py-2 text-sm text-white hover:bg-pink-600">
              {isEditing ? 'Save' : 'Create'}
            </button>
            <a href="/products" className="flex-1 rounded-lg border border-gray-300 px-4 py-2 text-center text-sm hover:bg-gray-50">
              Cancel
            </a>
          </div>
        </form>
      </div>
    </AppLayout>
  )
}