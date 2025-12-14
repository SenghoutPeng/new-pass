<template>
  <div class="min-h-screen bg-gray-100 flex items-center justify-center px-4">
    <div class="w-full max-w-lg bg-white shadow-lg rounded-2xl p-10">

      <div class="text-center mb-8">
        <h1 class="text-3xl font-bold text-indigo-700">Sign in to your account</h1>
        <p class="text-lg text-gray-700 font-medium mt-1">Welcome back!</p>
      </div>

      <form @submit.prevent="handleLogin" class="space-y-6">
        <div>
          <label for="email" class="block text-sm font-semibold text-gray-800 mb-1">Email:</label>
          <input
            v-model="form.email"
            type="email"
            id="email"
            required
            class="w-full px-4 py-3 bg-indigo-50 border border-indigo-100 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 placeholder-gray-400"
            placeholder="you@example.com"
          />
        </div>

        <div>
          <label for="password" class="block text-sm font-semibold text-gray-800 mb-1">Password:</label>
          <input
            v-model="form.password"
            type="password"
            id="password"
            required
            class="w-full px-4 py-3 bg-indigo-50 border border-indigo-100 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 placeholder-gray-400"
            placeholder="Enter your password"
          />
        </div>

        <div v-if="loginError" class="text-red-600 text-sm text-center">
          {{ loginError }}
        </div>

        <button
          type="submit"
          :disabled="processing"
          class="w-full bg-indigo-600 text-white font-semibold py-3 rounded-lg hover:bg-indigo-700 transition disabled:opacity-50"
        >
          <span v-if="processing">Signing In...</span>
          <span v-else>Sign In</span>
        </button>

        <p class="text-center text-sm text-gray-600 mt-4">
          Don’t have an account?
          <NuxtLink to="/signup" class="text-indigo-600 hover:underline font-semibold ml-1">Sign UP!</NuxtLink>
        </p>
      </form>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';

// Get the login function and the reactive user object from useSanctumAuth
const { login, user } = useSanctumAuth();
const router = useRouter();

// Reactive variables for form data, loading state, and error messages
const form = ref({ email: '', password: '' });
const processing = ref(false); // Controls the disabled state of the login button
const loginError = ref(null);  // Displays any login error messages

// Define page-specific metadata, including layout and middleware
definePageMeta({
  layout: 'auth',              // Uses the 'auth' layout
  middleware: 'sanctum:guest'  // Ensures this page is only accessible to unauthenticated users
});

/**
 * Handles the user login process.
 * Attempts to log in, saves the token manually if available, and redirects on success.
 */
const handleLogin = async () => {
  processing.value = true;   // Set processing state to true to disable button
  loginError.value = null;   // Clear any previous error messages

  try {

    const response = await login(form.value);
    location.reload();


    console.log('Response from useSanctumAuth login:', response); // Log the full response to debug

    if (response && response.token) { // Check if the 'token' property exists in the response
      if (process.client) { 
        localStorage.setItem('user_token', response.token);
        console.log('Manually saved user_token to localStorage:', response.token);
      }
    } else {
      console.warn('No "token" property found in login response. If you intend to use API tokens, check your Laravel backend\'s login response format.');
  
    }
   
    if (user.value) {
      router.push('/profile');
    } else {
      console.warn('Sanctum user object not immediately populated after login. Redirecting to general home.');
      router.push('/');
    }

  } catch (error) {
    console.error('Login failed:', error); // Log the full error for debugging

    // Handle and display specific error messages from the backend
    if (error.response && error.response._data && error.response._data.message) {
      loginError.value = error.response._data.message; } else {
      loginError.value = 'An unexpected error occurred during login. Please try again.';
    }
  } finally {
    processing.value = false;
  }
};
</script>