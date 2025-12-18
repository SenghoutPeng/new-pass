<template>
  <div class="min-h-screen bg-gray-900 flex items-center justify-center">
    <div class="bg-white rounded-lg shadow-lg p-8 w-full max-w-md">
      <h1 class="text-2xl font-bold text-gray-800 mb-2">Change Password</h1>
      <p class="text-sm text-gray-600 mb-6">Your password has expired, please choose a new password</p>

      <!-- Old Password -->
      <div class="mb-4">
        <label class="block text-sm font-medium text-gray-700 mb-1">Old Password:</label>
        <div class="relative">
          <input
            v-model="oldPassword"
            :type="showOld ? 'text' : 'password'"
            class="w-full border rounded-lg px-4 py-2 pr-10 bg-gray-100"
          />
          <button
            @click="showOld = !showOld"
            type="button"
            class="absolute right-2 top-1/2 transform -translate-y-1/2 text-gray-500"
          >
            <svg v-if="showOld" xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-5 0-9-4-9-9 0-.714.075-1.409.213-2.083M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
            </svg>
            <svg v-else xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-5 0-9-4-9-9 0-.714.075-1.409.213-2.083M15 12a3 3 0 11-6 0 3 3 0 016 0zM3 3l18 18" />
            </svg>
          </button>
        </div>
      </div>

      <!-- New Password -->
      <div class="mb-4">
        <label class="block text-sm font-medium text-gray-700 mb-1">New Password:</label>
        <p class="text-xs text-gray-500 mb-1">Your new password must be at least eight characters.</p>
        <div class="relative">
          <input
            v-model="newPassword"
            :type="showNew ? 'text' : 'password'"
            class="w-full border rounded-lg px-4 py-2 pr-10 bg-blue-50"
          />
          <button
            @click="showNew = !showNew"
            type="button"
            class="absolute right-2 top-1/2 transform -translate-y-1/2 text-gray-500"
          >
            <svg v-if="showNew" xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-5 0-9-4-9-9 0-.714.075-1.409.213-2.083M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
            </svg>
            <svg v-else xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-5 0-9-4-9-9 0-.714.075-1.409.213-2.083M15 12a3 3 0 11-6 0 3 3 0 016 0zM3 3l18 18" />
            </svg>
          </button>
        </div>
      </div>

      <!-- Confirm New Password -->
      <div class="mb-6">
        <label class="block text-sm font-medium text-gray-700 mb-1">Confirm New Password:</label>
        <div class="relative">
          <input
            v-model="confirmPassword"
            :type="showConfirm ? 'text' : 'password'"
            class="w-full border rounded-lg px-4 py-2 pr-10 bg-blue-50"
          />
          <button
            @click="showConfirm = !showConfirm"
            type="button"
            class="absolute right-2 top-1/2 transform -translate-y-1/2 text-gray-500"
          >
            <svg v-if="showConfirm" xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-5 0-9-4-9-9 0-.714.075-1.409.213-2.083M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
            </svg>
            <svg v-else xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-5 0-9-4-9-9 0-.714.075-1.409.213-2.083M15 12a3 3 0 11-6 0 3 3 0 016 0zM3 3l18 18" />
            </svg>
          </button>
        </div>
      </div>

      <!-- Submit Button -->
      <button
        @click="submit"
        class="w-full bg-blue-500 hover:bg-blue-600 text-white font-medium py-2 rounded-lg"
      >
        Confirm
      </button>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';

const router = useRouter();
const client = useSanctumClient();
const config = useRuntimeConfig();
const oldPassword = ref('');
const newPassword = ref('');
const confirmPassword = ref('');
const showOld = ref(false);
const showNew = ref(false);
const showConfirm = ref(false);

const submit = async () => {
  if (newPassword.value !== confirmPassword.value) {
    alert('New passwords do not match!');
    return;
  }
  if (newPassword.value.length < 8) {
    alert('New password must be at least 8 characters.');
    return;
  }
  try {
    const response = await client(`${config.public.apiUrl}/change-password`, {
      method: 'POST',
      body: {
        current_password: oldPassword.value,
        password: newPassword.value,
        password_confirmation: confirmPassword.value
      },
      credentials: 'include'
    });

    alert(response.message || 'Password changed successfully!');
    router.push('/profile');
  } catch (error) {
    console.error('Error:', error);
    if (error.data && error.data.message) {
      alert(`❌ ${error.data.message}`);
    } else {
      alert('❌ Failed to change password.');
    }
  }
};
</script>

