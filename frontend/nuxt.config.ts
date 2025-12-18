// nuxt.config.ts
import tailwindcss from '@tailwindcss/vite'

export default defineNuxtConfig({

  devtools: { enabled: true },

  css: ['~/assets/css/main.css'],

  vite: {
    plugins: [
      tailwindcss(),
    ],
  },

  modules: [
    'nuxt-auth-sanctum',
  ],

  sanctum: {
    baseUrl: 'http://localhost:8000',// Replace with Laravel Server IP without port(eg. http://146.190.87.95)
    endpoints: {
      login: '/api/login',
      logout: '/api/logout',
    },
    redirect: {
      onLogin: '/',
      onLogout: '/login'
    }
  },

  runtimeConfig: {
    public: {
      baseUrl: 'http://localhost:8000',// Replace with Laravel Server IP without port(eg. http://146.190.87.95)
      apiUrl: 'http://localhost:8000/api'// Replace with Laravel Server IP without port(eg. http://146.190.87.95/api)
    }
  }
})