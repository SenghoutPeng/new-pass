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
    baseUrl: 'http://localhost:8000',  
    endpoints: {
      login: '/api/login',
      logout: '/api/logout',
      csrf: '/sanctum/csrf-cookie'
    },
    redirect: {
      onLogin: '/',
      onLogout: '/login'
    }
  },

  runtimeConfig: {
    public: {
      baseUrl: 'http://localhost:8000'
    }
  }
})