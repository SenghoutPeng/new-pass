<template>
  <div>
    <div class="navbar bg-white shadow-sm flex flex-wrap justify-between px-4">
      <div class="flex items-center gap-2">
        <button class="btn btn-square btn-ghost" @click="toggleSidebar">
          <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"
            class="inline-block h-5 w-5 stroke-current">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
              d="M4 6h16M4 12h16M4 18h16" />
          </svg>
        </button>
       
      </div>

      <div class="flex items-center gap-2">
        <div class="dropdown dropdown-end">
          <button class="btn border-0 rounded bg-red-500 text-white" @click="handleLogout">
            Sign Out
            </button>

        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { defineEmits } from 'vue';
import { useRuntimeConfig, navigateTo } from '#app';

const emit = defineEmits(['toggle-sidebar'])

const toggleSidebar = () => {
  emit('toggle-sidebar')
}

// Get the runtime configuration
const config = useRuntimeConfig();

// Function to get a specific cookie value by name
const getCookie = (name) => {
  const value = `; ${document.cookie}`;
  const parts = value.split(`; ${name}=`);
  if (parts.length === 2) return parts.pop().split(';').shift();
  return null;
};

const handleLogout = async () => {
  try {
    //Get CSRF cookie from Sanctum
    // This is important for stateful authentication if you're mixing SPA and traditional auth,
    // but for pure API token auth, the Bearer token is primary for authentication.
    // However, keeping it here ensures full compatibility with Sanctum's CSRF protection.
    await $fetch(`${config.public.baseUrl}/sanctum/csrf-cookie`, {
      credentials: 'include'
    })

    // Step 2: Get the XSRF-TOKEN from the cookies
    const xsrfToken = getCookie('XSRF-TOKEN');

    if (!xsrfToken) {
      console.warn('CSRF token not found. Logout might still proceed if token auth is primary, but consider Sanctum configuration.');
    }

    // Retrieve the admin token from localStorage
    const adminToken = localStorage.getItem('admin_token');

    if (!adminToken) {
      console.error('Admin token not found in localStorage. Cannot log out without a token.');
      navigateTo('/admin/login'); // Redirect to login if no token is found
      return;
    }

    // Perform logout request with X-XSRF-TOKEN header AND Authorization Bearer token
    await $fetch(`${config.public.baseUrl}/api/admin/logout`, {
      method: 'POST',
      credentials: 'include',
      headers: {
        'Content-Type': 'application/json',
        'X-XSRF-TOKEN': xsrfToken ? decodeURIComponent(xsrfToken) : '', // Include if available
        'Authorization': `Bearer ${adminToken}`
      }
    })

    // If logout is successful, remove the token from localStorage and redirect
    localStorage.removeItem('admin_token');
    localStorage.removeItem('admin_email'); // Also remove email if you store it

    console.log('Logged out successfully.');
    navigateTo('/admin/login');

  } catch (error) {
    console.error('Logout failed:', error);
    // If a 401 occurs, it might mean the token was already invalid/expired on the server,
    // so clearing local storage and redirecting might still be appropriate.
    localStorage.removeItem('admin_token');
    localStorage.removeItem('admin_email');
    navigateTo('/admin/login');
  }
}
</script>