<template>
  <div class="min-h-screen bg-gray-100 flex items-center justify-center px-4">
    <div class="w-full max-w-lg bg-white shadow-lg rounded-2xl p-10">
      <div class="text-center mb-8">
        <h1 class="text-3xl font-bold text-indigo-700">Sign in Account For <span class="italic">Organization</span></h1>
        <p class="text-lg text-gray-700 font-medium mt-1">Hello, Welcome back!</p>
      </div>

      <form @submit.prevent="handleLogin" class="space-y-6">
        <!-- Error Message -->
        <div
          v-if="loginError"
          class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-4"
          role="alert"
        >
          <span class="block sm:inline">{{ loginError }}</span>
        </div>

        <!-- Email -->
        <div>
          <label for="email" class="block text-sm font-semibold text-gray-800 mb-1">Email:</label>
          <input
            v-model="form.email"
            type="email"
            id="email"
            required
            class="w-full px-4 py-3 bg-indigo-50 border border-indigo-100 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 placeholder-gray-400"
            placeholder="organization@example.com"
          />
        </div>

        <!-- Password with toggle -->
        <div>
          <label for="password" class="block text-sm font-semibold text-gray-800 mb-1">Password:</label>
          <div class="relative">
            <input
              v-model="form.password"
              :type="showPassword ? 'text' : 'password'"
              id="password"
              required
              class="w-full px-4 py-3 pr-12 bg-indigo-50 border border-indigo-100 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500 placeholder-gray-400"
              placeholder="Enter your password"
            />
            <button
              type="button"
              @click="showPassword = !showPassword"
              class="absolute inset-y-0 right-3 flex items-center text-gray-500 hover:text-indigo-700"
              tabindex="-1"
            >
              <!-- Eye closed -->
              <svg v-if="!showPassword" class="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-width="2"
                      d="M21 12c0 1.2-4.03 6-9 6s-9-4.8-9-6c0-1.2 4.03-6 9-6s9 4.8 9 6Z" />
                <path stroke-width="2"
                      d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
              </svg>
              <!-- Eye open with slash -->
              <svg v-else class="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                      d="M3.933 13.909A4.357 4.357 0 0 1 3 12c0-1 4-6 9-6m7.6 3.8A5.068 5.068 0 0 1 21 12c0 1-3 6-9 6-.314 0-.62-.014-.918-.04M5 19 19 5m-4 7a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z" />
              </svg>
            </button>
          </div>
        </div>

        <!-- Forgot Password -->
        <div class="text-center">
          <NuxtLink to="/forgot-password-organization" class="text-sm font-semibold text-indigo-600 hover:underline">
            Forgot Password?
          </NuxtLink>
        </div>

        <!-- Submit -->
        <button
          type="submit"
          :disabled="loading"
          class="w-full bg-indigo-600 text-white font-semibold py-3 rounded-lg hover:bg-indigo-700 transition disabled:opacity-50"
        >
          <span v-if="loading">Signing In...</span>
          <span v-else>Sign In</span>
        </button>

        <!-- Register -->
        <p class="text-center text-sm text-gray-600 mt-4">
          Don’t have an account?
          <NuxtLink to="/organization/signup" class="text-indigo-600 hover:underline font-semibold ml-1">
            Sign UP!
          </NuxtLink>
        </p>
      </form>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useSanctumClient, useRuntimeConfig, navigateTo, definePageMeta } from '#imports'

definePageMeta({
  middleware: 'org-guest',
})

const form = ref({
  email: '',
  password: ''
})

const showPassword = ref(false)
const loading = ref(false)
const loginError = ref('')

const config = useRuntimeConfig()
const client = useSanctumClient()

const handleLogin = async () => {
  loading.value = true
  loginError.value = ''

  try {
    const response = await client(`${config.public.baseUrl}/api/organization/login`, {
      method: 'POST',
      body: form.value,
      credentials: 'include'
    })

    // Store token in localStorage for route guards
    localStorage.setItem('org_token', response.token)

    await navigateTo('/organization/')
    location.reload() 
  } catch (error) {
    console.error('Login error:', error)
    loginError.value = error?.response?._data?.message || 'Login failed. Please check your credentials.'
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
/* Tailwind handles styling */
</style>
