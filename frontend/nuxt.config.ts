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
    baseUrl: 'http://127.0.0.1:8000',
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
      baseUrl: 'http://127.0.0.1:8000',
      apiUrl: 'http://127.0.0.1:8000/api'
    }
  }
})