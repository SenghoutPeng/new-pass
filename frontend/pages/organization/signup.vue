<template>
  <div class="min-h-screen bg-gray-100 flex items-center justify-center px-4">
    <div class="w-full max-w-lg bg-white shadow-lg rounded-2xl p-10">
      <div class="text-center mb-8">
        <h1 class="text-3xl font-bold text-indigo-700">Create an Organization Account</h1>
        <p class="text-lg text-gray-700 font-medium mt-1">Join us to plan amazing events!</p>
      </div>

      <form @submit.prevent="handleSignUp" class="space-y-5">
        <!-- General error display -->
        <div v-if="errors.general" class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative" role="alert">
          <span class="block sm:inline">{{ errors.general }}</span>
        </div>

        <div>
          <input
            type="text"
            v-model="FormData.org_name"
            placeholder="Organization Name"
            class="w-full px-4 py-3 bg-indigo-50 border border-indigo-100 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500 placeholder-gray-400"
            required
          />
        </div>

        <div>
          <input
            type="email"
            v-model="FormData.email"
            placeholder="Organization Email"
            class="w-full px-4 py-3 bg-indigo-50 border border-indigo-100 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500 placeholder-gray-400"
            required
          />
        </div>

        <!-- Password -->
        <div class="relative">
          <input
            :type="showPassword ? 'text' : 'password'"
            v-model="FormData.password"
            placeholder="Password"
            class="w-full px-4 py-3 pr-12 bg-indigo-50 border border-indigo-100 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500 placeholder-gray-400"
            required
          />
          <button
            type="button"
            @click="showPassword = !showPassword"
            class="absolute inset-y-0 right-3 flex items-center text-gray-500 hover:text-indigo-700"
            tabindex="-1"
          >
            <svg v-if="!showPassword" class="w-6 h-6 text-gray-800 dark:text-black" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
              <path stroke="currentColor" stroke-width="2" d="M21 12c0 1.2-4.03 6-9 6s-9-4.8-9-6c0-1.2 4.03-6 9-6s9 4.8 9 6Z"/>
              <path stroke="currentColor" stroke-width="2" d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z"/>
            </svg>

            <svg v-else class="w-6 h-6 text-gray-800 dark:text-black" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
              <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3.933 13.909A4.357 4.357 0 0 1 3 12c0-1 4-6 9-6m7.6 3.8A5.068 5.068 0 0 1 21 12c0 1-3 6-9 6-.314 0-.62-.014-.918-.04M5 19 19 5m-4 7a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z"/>
            </svg>

          </button>
        </div>

        <!-- Confirm Password -->
        <div class="relative">
          <input
            :type="showPassword ? 'text' : 'password'"
            v-model="FormData.password_confirmation"
            placeholder="Confirm Password"
            class="w-full px-4 py-3 pr-12 bg-indigo-50 border border-indigo-100 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500 placeholder-gray-400"
            required
          />
          <button
            type="button"
            @click="showPassword = !showPassword"
            class="absolute inset-y-0 right-3 flex items-center text-gray-500 hover:text-indigo-700"
            tabindex="-1"
          >
            <svg v-if="!showPassword" class="w-6 h-6 text-gray-800 dark:text-black" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
              <path stroke="currentColor" stroke-width="2" d="M21 12c0 1.2-4.03 6-9 6s-9-4.8-9-6c0-1.2 4.03-6 9-6s9 4.8 9 6Z"/>
              <path stroke="currentColor" stroke-width="2" d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z"/>
            </svg>

            <svg v-else class="w-6 h-6 text-gray-800 dark:text-black" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
              <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3.933 13.909A4.357 4.357 0 0 1 3 12c0-1 4-6 9-6m7.6 3.8A5.068 5.068 0 0 1 21 12c0 1-3 6-9 6-.314 0-.62-.014-.918-.04M5 19 19 5m-4 7a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z"/>
            </svg>

          </button>
        </div>

        <div>
          <select
            v-model="FormData.org_type"
            class="w-full px-4 py-3 bg-indigo-50 border border-indigo-100 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500 text-gray-700"
            required
          >
            <option value="">Select Organization Type</option>
            <option value="nonprofit">Non-profit</option>
            <option value="company">Company</option>
            <option value="school">School</option>
          </select>
        </div>

        <div>
          <input
            type="text"
            v-model="FormData.contact_name"
            placeholder="Contact Name"
            class="w-full px-4 py-3 bg-indigo-50 border border-indigo-100 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500 placeholder-gray-400"
            required
          />
        </div>

        <div>
          <input
            type="text"
            v-model="FormData.contact_phone"
            placeholder="Contact Phone"
            class="w-full px-4 py-3 bg-indigo-50 border border-indigo-100 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500 placeholder-gray-400"
            required
          />
        </div>

        <div>
          <input
            type="email"
            v-model="FormData.contact_email"
            placeholder="Contact Email"
            class="w-full px-4 py-3 bg-indigo-50 border border-indigo-100 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500 placeholder-gray-400"
            required
          />
        </div>

        <button
          type="submit"
          :disabled="loading"
          class="w-full bg-indigo-600 text-white font-semibold py-3 rounded-lg hover:bg-indigo-700 transition disabled:opacity-50"
        >
          <span v-if="loading">Signing Up...</span>
          <span v-else>Sign Up</span>
        </button>

        <p class="text-center text-sm text-gray-600 mt-4">
          Already have an account?
          <NuxtLink to="/organization/login" class="text-indigo-600 hover:underline font-semibold ml-1">Login</NuxtLink>
        </p>
      </form>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useSanctumAuth, useSanctumClient, useRuntimeConfig, useHead, definePageMeta, navigateTo } from '#imports'

const { login } = useSanctumAuth()
const client = useSanctumClient()
const config = useRuntimeConfig()

useHead({ title: 'Organization Sign Up' })

definePageMeta({
  layout: 'auth',
  middleware: 'sanctum:guest'
})

const showPassword = ref(false)
const loading = ref(false)
const errors = ref({})

const FormData = ref({
  org_name: '',
  email: '',
  password: '',
  password_confirmation: '',
  org_type: '',
  contact_name: '',
  contact_phone: '',
  contact_email: ''
})

const handleSignUp = async () => {
  errors.value = {}
  loading.value = true

  try {
     const response =await client(`${config.public.apiUrl}/organization/signup`, {
      method: 'POST',
      body: FormData.value,
      credentials: 'include'
    })

    await client(`${config.public.apiUrl}organization/login`, {
      method: 'POST',
      body: {
        email: FormData.value.email,
        password: FormData.value.password
      },
      credentials: 'include'
      

    })
    localStorage.setItem('org_token', response.token)
    
    await navigateTo('/organization/dashboard')
    
    location.reload()
  } catch (err) {
    console.error('Signup/Login Error:', err)

    if (err?.response?._data?.errors) {
      errors.value = err.response._data.errors
    } else if (err?.response?._data?.message) {
      errors.value.general = err.response._data.message
    } else {
      errors.value.general = 'An unexpected error occurred. Please try again.'
    }
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
/* No extra styles needed, Tailwind handles everything */
</style>
