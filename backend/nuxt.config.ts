import tailwindcss from "@tailwindcss/vite";
const backendUrl = 'http://localhost:8000' // Replace with Laravel Server IP without port(eg. http://146.190.87.95)
export default defineNuxtConfig({
  compatibilityDate: '2025-05-15',
  devtools: { enabled: true },
   app: {
    head: {
       title: 'NewPass',
      link: [
       { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico'},
      ],
    }
  },
  css: ['~/assets/css/main.css'],
  vite: {
    plugins: [
      tailwindcss(),
    ],
  },
  modules: [
    '@nuxt/content',
    '@nuxt/eslint',
    '@nuxt/fonts',
    '@nuxt/icon',
    '@nuxt/image',
    '@nuxt/scripts',
    '@nuxt/test-utils',
    '@nuxt/ui',
    'nuxt-auth-sanctum'
  ],

  sanctum: {
    
    baseUrl: backendUrl,
    endpoints: {
      login: '/api/login',
      logout: '/api/logout'
    },
    redirect: {
      onLogin: '/',
      onLogout: '/login'
    }
  },
  runtimeConfig: {
    public: {
      baseUrl: backendUrl,
      apiUrl: `${backendUrl}/api`
    }
  }
})