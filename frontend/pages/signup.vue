<template>
  <div class="min-h-screen bg-gray-100 flex items-center justify-center px-4">
    <div class="w-full max-w-4xl bg-white shadow-xl rounded-2xl overflow-hidden grid grid-cols-1 md:grid-cols-2">

      <div class="bg-gradient-to-br from-blue-500 to-blue-600 p-8 flex flex-col justify-center items-center relative">
        <div class="absolute inset-0 opacity-10 rounded-2xl" style="background: radial-gradient(circle at center, rgba(255,255,255,0.3) 0%, transparent 70%)"></div>
        <div class="relative z-10">
          <div class="w-32 h-32 bg-white bg-opacity-10 rounded-full blur-2xl mb-6"></div>
          <div class="flex justify-center space-x-2 mt-8">
            <div class="w-2 h-2 bg-white/30 rounded-full"></div>
            <div class="w-2 h-2 bg-white/50 rounded-full"></div>
            <div class="w-2 h-2 bg-white rounded-full"></div>
          </div>
        </div>
      </div>

      <div class="p-10">
        <h1 class="text-2xl font-bold text-gray-800 mb-1">Create Account</h1>
        <p class="text-sm text-gray-500 mb-6">Sign up to get started with our service</p>

        <form @submit.prevent="handleSignup" class="space-y-5">
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Username</label>
            <input v-model="form.username" type="text" required placeholder="Choose a username"
              class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" />
            <p v-if="validationErrors.username" class="text-red-500 text-xs mt-1">{{ validationErrors.username[0] }}</p>
          </div>

          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Email</label>
            <input v-model="form.email" type="email" required placeholder="you@example.com"
              class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" />
            <p v-if="validationErrors.email" class="text-red-500 text-xs mt-1">{{ validationErrors.email[0] }}</p>
          </div>

          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Password</label>
            <input v-model="form.password" :type="showPassword ? 'text' : 'password'" required placeholder="Create a password"
              class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" />
            <p class="text-xs text-gray-400 mt-1">Must be at least 8 characters</p>
            <p v-if="validationErrors.password" class="text-red-500 text-xs mt-1">{{ validationErrors.password[0] }}</p>
          </div>

          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Confirm Password</label>
            <input v-model="form.confirmPassword" :type="showConfirmPassword ? 'text' : 'password'" required placeholder="Confirm Password"
              :class="[ 'w-full px-4 py-2 border rounded-lg focus:outline-none focus:ring-2',
                        form.confirmPassword && form.password !== form.confirmPassword ? 'border-red-400 focus:ring-red-400' : 'border-gray-300 focus:ring-blue-500']" />
            <p class="text-xs mt-1" :class="form.confirmPassword && form.password !== form.confirmPassword ? 'text-red-600' : 'text-gray-400'">
              Must match the password you want to create
            </p>
            </div>

          <div v-if="apiError" class="text-red-600 text-sm text-center">
            {{ apiError }}
          </div>

          <button type="submit" :disabled="loading || !isFormValid"
            class="w-full bg-blue-600 text-white font-medium py-2 rounded-lg hover:bg-blue-700 transition disabled:opacity-50">
            <span v-if="loading">Creating Account...</span>
            <span v-else>Create Account</span>
          </button>

          <p class="text-sm text-center text-gray-500 mt-4">
            Already have an account?
            <NuxtLink to="/login" class="text-blue-600 hover:underline">Log in</NuxtLink>
          </p>
        </form>
      </div>
    </div>
  </div>
  
  </template>


<script setup>
import { ref, computed } from 'vue' // Make sure ref and computed are imported
import { useRouter } from 'vue-router' // Import useRouter for navigation
import { useSanctumAuth } from '#imports'

definePageMeta({
  middleware: 'sanctum:guest' // Ensure this page is only accessible to guests
})

const { login } = useSanctumAuth()

const router = useRouter()
const config = useRuntimeConfig() // Access runtime config for base URL
const client = useSanctumClient()
const form = ref({
  username: '',
  email: '',
  password: '',
  confirmPassword: '',
})

const showPassword = ref(false)
const showConfirmPassword = ref(false)
const loading = ref(false)
const apiError = ref(null) // For general API errors
const validationErrors = ref({}) // For Laravel validation errors

const isFormValid = computed(() => {
  // Basic frontend validation for button disabled state
  return form.value.username &&
         form.value.email &&
         form.value.password && form.value.password.length >= 8 && // Added min length check
         form.value.confirmPassword &&
         form.value.password === form.value.confirmPassword
})

const handleSignup = async () => {
  if (!isFormValid.value) {
      alert('Please fill all fields correctly, and ensure password is at least 8 characters and matches confirmation.');
      return;
  }

  loading.value = true
  apiError.value = null 
  validationErrors.value = {} 

  try {
    // 1. Fetch CSRF cookie (essential for Laravel Sanctum POST requests)
    await $fetch(`${config.public.baseUrl}/sanctum/csrf-cookie`, {
      credentials: 'include' // Important for sending/receiving cookies
    })

    // 2. Send signup data to Laravel backend
    const response = await client(`${config.public.baseUrl}/api/signup`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: {
        username: form.value.username,
        email: form.value.email,
        password: form.value.password,
        password_confirmation: form.value.confirmPassword, // Laravel's 'confirmed' rule expects this name
      },
    })
    
    // Assuming successful signup, store the token
    if (response.token && process.client) {
      localStorage.setItem('user_token', response.token);
    }
    
    alert('Account created successfully!');

    await login({
      email: form.value.email,
      password: form.value.password
    });
    router.push('/profile'); // Redirect to user profile or another relevant page
    
  } catch (error) {
    console.error('Signup failed:', error);
    if (error.statusCode === 422) {
      // Laravel validation errors
      validationErrors.value = error.data.errors || {};
      apiError.value = error.data.message || 'Please check your input for errors.';
    } else if (error.data && error.data.message) {
      // Other API errors with a message
      apiError.value = error.data.message;
    } else {
      apiError.value = 'Signup failed. Please try again later.';
    }
  } finally {
    loading.value = false
  }
}
</script>