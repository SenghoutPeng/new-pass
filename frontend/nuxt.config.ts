// https://nuxt.com/docs/api/configuration/nuxt-config
import tailwindcss from "@tailwindcss/vite";

export default defineNuxtConfig({
  compatibilityDate: '2025-05-15',
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
    baseUrl: 'http://localhost:8000', // Laravel API server IP address
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
      baseUrl: 'http://localhost:8000' // Laravel API server IP address
    }
  }
})
