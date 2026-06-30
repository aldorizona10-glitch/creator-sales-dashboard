import React, { useState } from 'react'
import AppLayout from '@/Layouts/AppLayout'

export default function Login() {
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')

  return (
    <AppLayout>
      <div className="mx-auto max-w-sm space-y-6">
        <div>
          <h1 className="text-2xl font-semibold">Sign in</h1>
          <p className="mt-1 text-sm text-gray-600">
            Enter your email and password to access your dashboard
          </p>
        </div>

        <form method="post" action="/session" className="space-y-4">
          <input type="hidden" name="_method" value="post" />

          <div>
            <label htmlFor="email" className="mb-1 block text-sm font-medium">Email</label>
            <input
              id="email"
              type="email"
              name="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              className="w-full rounded-lg border border-gray-300 px-3 py-2 text-sm focus:border-pink-500 focus:outline-none focus:ring-1 focus:ring-pink-500"
              placeholder="demo@creator.dev"
              required
            />
          </div>

          <div>
            <label htmlFor="password" className="mb-1 block text-sm font-medium">Password</label>
            <input
              id="password"
              type="password"
              name="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              className="w-full rounded-lg border border-gray-300 px-3 py-2 text-sm focus:border-pink-500 focus:outline-none focus:ring-1 focus:ring-pink-500"
              required
            />
          </div>

          <button
            type="submit"
            className="w-full rounded-lg bg-pink-500 px-4 py-2 text-sm font-medium text-white hover:bg-pink-600"
          >
            Sign in
          </button>
        </form>

        <p className="text-center text-xs text-gray-500">
          Don't have an account?{' '}
          <a href="/registration/new" className="text-pink-500 hover:underline">Create one</a>
        </p>
      </div>
    </AppLayout>
  )
}