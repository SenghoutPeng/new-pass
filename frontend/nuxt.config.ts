// nuxt.config.ts
import tailwindcss from '@tailwindcss/vite'
const backendUrl = 'http://localhost:8000' // Replace with Laravel Server IP without port(eg. http://146.190.87.95)
export default defineNuxtConfig({

  devtools: { enabled: true },
  app: {
    head: {
      title: 'NewPass',
      link: [
        { rel: 'icon', type: 'image/x-icon', href: '/newpass.ico'},
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
    'nuxt-auth-sanctum',
  ],
  
  
  sanctum: {
    baseUrl: backendUrl,
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
      baseUrl: backendUrl,
      apiUrl: `${backendUrl}/api`
    }
  }
})