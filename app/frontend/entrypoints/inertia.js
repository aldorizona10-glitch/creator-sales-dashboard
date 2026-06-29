import { createInertiaApp } from '@inertiajs/inertia-react'
import { createRoot } from 'react-dom/client'

// Plain JS entry — no TypeScript, no type assertions
// Vite builds this as a standard JSX entrypoint
const pages = import.meta.glob('../Pages/**/*.tsx', { eager: true })

createInertiaApp({
  resolve: async (name) => {
    const path = `../Pages/${name}.tsx`
    const pageModule = pages[path]
    if (!pageModule) {
      throw new Error(`Inertia page not found: ${name} (looked at ${path})`)
    }
    return pageModule.default
  },
  setup({ el, App, props }) {
    const root = createRoot(el)
    root.render(h(React.createElement(App), props))
  },
  progress: {
    color: '#FF90E8',
    showSpinner: false,
  },
})