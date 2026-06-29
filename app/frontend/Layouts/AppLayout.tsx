import React from 'react'
import { Link, usePage } from '@inertiajs/inertia-react'

type Creator = {
  id: number
  email: string
  name: string
}

type SharedProps = {
  creator?: Creator
  flash?: { notice?: string; alert?: string }
}

export default function AppLayout({ children }: { children: React.ReactNode }) {
  const { props } = usePage<SharedProps>()
  const creator = props.creator

  return (
    <div className="min-h-screen bg-gray-50 text-gray-900 antialiased dark:bg-gray-950 dark:text-gray-100">
      <header className="border-b border-gray-200 bg-white dark:border-gray-800 dark:bg-gray-900">
        <div className="mx-auto flex max-w-6xl items-center justify-between px-6 py-4">
          <Link href="/" className="flex items-center gap-2 text-lg font-semibold">
            <span className="inline-block h-6 w-6 rounded bg-gradient-to-br from-pink-400 to-pink-600" />
            <span>Creator Sales</span>
          </Link>
          {creator && (
            <div className="flex items-center gap-3 text-sm text-gray-600 dark:text-gray-400">
              <span>{creator.name}</span>
              <span>·</span>
              <Link href="/logout" method="delete" as="button" className="hover:text-gray-900 dark:hover:text-white">
                Sign out
              </Link>
            </div>
          )}
        </div>
      </header>

      {props.flash?.notice && (
        <div className="border-b border-green-200 bg-green-50 px-6 py-3 text-sm text-green-900 dark:border-green-800 dark:bg-green-950 dark:text-green-100">
          {props.flash.notice}
        </div>
      )}
      {props.flash?.alert && (
        <div className="border-b border-red-200 bg-red-50 px-6 py-3 text-sm text-red-900 dark:border-red-800 dark:bg-red-950 dark:text-red-100">
          {props.flash.alert}
        </div>
      )}

      <main className="mx-auto max-w-6xl px-6 py-10">{children}</main>
    </div>
  )
}
