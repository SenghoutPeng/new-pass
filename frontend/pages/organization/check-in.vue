<template>
  <div class="flex min-h-screen bg-gray-100">
    <div class="flex-1 flex flex-col">
      <main class="flex-1 p-8 overflow-y-auto flex items-center justify-center">
        <div class="bg-white p-8 rounded-lg shadow-md max-w-lg w-full text-center">
          <h1 class="text-3xl font-bold text-gray-800 mb-4">Check-in</h1>
          <p class="text-gray-600 mb-8">Enter your exclusive reservation code to access your VIP experience</p>

          <div class="border border-gray-200 rounded-lg p-6">
            <div class="text-5xl text-indigo-600 mb-4">
              <i class="fas fa-ticket-alt"></i>
            </div>
            <h2 class="text-xl font-semibold text-gray-800 mb-2">Reservation Code</h2>
            <p class="text-gray-600 text-sm mb-4">Please enter your text reservation code</p>

            <div class="text-left mb-6">
              <label for="reservationCode" class="block text-sm font-medium text-gray-700 mb-2">Reservation Code</label>
              <div class="relative">
                <!-- SVG positioned inside the input -->
                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                  <svg class="w-5 h-5 text-gray-500" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m8 8-4 4 4 4m8 0 4-4-4-4m-2-3-4 14"/>
                  </svg>
                </div>

                <!-- Input with left padding -->
                <input
                  type="text"
                  id="reservationCode"
                  v-model="reservationCode"
                  placeholder="Enter text code"
                  class="pl-10 pr-3 py-2 block w-full border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                />
              </div>
            </div>

            <div class="flex justify-between items-center">
              <button
                @click="handleCheckIn"
                class="flex-1 mr-2 px-6 py-3 bg-indigo-600 text-white rounded-md hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 flex items-center justify-center"
              >
                <i class="fas fa-check-circle mr-2"></i> Check In
              </button>
              <button
                @click="handleNeedHelp"
                class="flex-1 ml-2 px-6 py-3 text-indigo-600 border border-indigo-600 rounded-md hover:bg-indigo-50 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 flex items-center justify-center"
              >
                <i class="fas fa-question-circle mr-2"></i> Need Help?
              </button>
            </div>
          </div>
        </div>
      </main>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
const client = useSanctumClient();
const config = useRuntimeConfig()
definePageMeta({
  layout: 'master',
  middleware: 'org-auth'
})

const reservationCode = ref('')

const handleCheckIn = async () => {
  if (reservationCode.value.trim() === '') {
    alert('Please enter a reservation code.')
    return
  }

  try {
    const res = await client(`${config.public.apiUrl}/organization/check-in`, {
      method: 'POST',
      body: {
        ticket_code: reservationCode.value.trim(),
      },
      credentials: 'include',
    })

    alert(`✅ ${res.message}\nEvent ID: ${res.event_id}\nUser ID: ${res.user_id}`)
  } catch (error) {
    const message = error?.response?._data?.message || '❌ Check-in failed.'
    alert(message)
    console.error('Check-in error:', error)
  }
}

const handleNeedHelp = () => {
  alert('Redirecting to help or contact support...')
}
</script>

<style scoped>
@import url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css');
</style>
