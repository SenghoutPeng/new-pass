<template>
  <div class="min-h-screen bg-gradient-to-br from-blue-100 to-blue-300 flex items-center justify-center px-4 py-12">
    <div class="w-full max-w-md bg-white rounded-2xl shadow-xl p-8">
      <div class="mb-6 text-center">
        <h2 class="text-3xl font-extrabold text-gray-800">Admin Login</h2>
      </div>
      <form @submit.prevent="handleLogin" class="space-y-4">
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1" for="email">Email</label>
          <input
            id="email"
            v-model="email"
            type="email"
            placeholder="admin@example.com"
            class="w-full px-4 py-2 rounded-lg border border-gray-300 focus:ring-2 focus:ring-blue-400 focus:outline-none text-gray-800"
          />
        </div>
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1" for="password">Password</label>
          <input
            id="password"
            v-model="password"
            type="password"
            placeholder="••••••••"
            class="w-full px-4 py-2 rounded-lg border border-gray-300 focus:ring-2 focus:ring-blue-400 focus:outline-none text-gray-800"
          />
        </div>
        <button
          type="submit"
          :disabled="loading"
          class="w-full bg-blue-600 hover:bg-blue-700 transition duration-150 text-white font-semibold py-2.5 rounded-lg shadow disabled:opacity-50"
        >
          {{ loading ? 'Signing In...' : 'Sign In' }}
        </button>
        <p v-if="error" class="text-sm text-red-600 mt-2 text-center">{{ error }}</p>
      </form>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const config = useRuntimeConfig()

definePageMeta({
  layout: 'false',
  middleware: 'sanctum-guest'
})

const email = ref('')
const password = ref('')
const error = ref('')
const loading = ref(false)

// Function to get a specific cookie value by name
const getCookie = (name) => {
  const value = `; ${document.cookie}`
  const parts = value.split(`; ${name}=`)
  if (parts.length === 2) return parts.pop().split(';').shift()
  return null
}

const handleLogin = async () => {
  error.value = ''
  loading.value = true
  
  try {
    // Step 1: Get CSRF cookie from Sanctum
    await fetch(`${config.public.baseUrl}/sanctum/csrf-cookie`, {
      method: 'GET',
      credentials: 'include'
    })

    // Small delay to ensure cookie is set
    await new Promise(resolve => setTimeout(resolve, 100))

    // Step 2: Get the XSRF-TOKEN from the cookies
    const xsrfToken = getCookie('XSRF-TOKEN')
    
    if (!xsrfToken) {
      throw new Error('CSRF token not found. Please ensure cookies are enabled.')
    }

    // Step 3: Perform login request with X-XSRF-TOKEN header
    const response = await fetch(`${config.public.apiUrl}/admin/login`, {
      method: 'POST',
      credentials: 'include',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-XSRF-TOKEN': decodeURIComponent(xsrfToken)
      },
      body: JSON.stringify({
        email: email.value,
        password: password.value
      })
    })

    const data = await response.json()

    if (!response.ok) {
      throw new Error(data.message || 'Login failed')
    }

    // Store token and user info
    localStorage.setItem('admin_token', data.token)
    localStorage.setItem('admin_email', data.admin.email)
    
    console.log('Login success:', data)
    
    // Redirect to admin dashboard
    await navigateTo('/admin')
  } catch (err) {
    console.error('Login error:', err)
    error.value = err.message || 'An unknown error occurred during login.'
  } finally {
    loading.value = false
  }
}
</script>