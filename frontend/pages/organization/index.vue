<template>
  <div class="flex min-h-screen bg-gray-100">
    <div class="flex-1 flex flex-col">
      <main class="flex-1 p-8 overflow-y-auto">
        <h1 class="text-2xl font-bold text-gray-800 mb-4">List of Buyers</h1>

        <!-- Event Filter Dropdown -->
        <div class="mb-6 w-full md:w-64">
          <label class="block text-sm font-medium text-gray-700 mb-1">Filter by Event</label>
          <select
            v-model="selectedEventId"
            @change="fetchBuyers"
            class="block w-full px-4 py-2 border border-gray-300 bg-white rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500"
          >
            <option value="">All Events</option>
            <option v-for="event in eventList" :key="event.id" :value="event.id">
              {{ event.name }}
            </option>
          </select>
        </div>

        <!-- Buyers Table -->
        <section class="bg-white p-8 rounded-lg shadow-md">
          <div class="overflow-x-auto">
            <table class="min-w-full text-sm text-left whitespace-nowrap">
              <thead class="bg-gray-100">
                <tr>
                  <th class="px-4 py-2 text-gray-700">DATE</th>
                  <th class="px-4 py-2 text-gray-700">ID</th>
                  <th class="px-4 py-2 text-gray-700">USER NAME</th>
                  <th class="px-4 py-2 text-gray-700">QUANTITY</th>
                  <th class="px-4 py-2 text-gray-700">TOTAL PRICE</th>
                  <th class="px-4 py-2 text-gray-700">EVENT</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="(buyer, index) in buyers" :key="index" class="border-t border-gray-200">
                  <td class="px-4 py-2">{{ buyer.date }}</td>
                  <td class="px-4 py-2">{{ buyer.id }}</td>
                  <td class="px-4 py-2 font-medium text-gray-900">{{ buyer.userName }}</td>
                  <td class="px-4 py-2">{{ buyer.quantity }}</td>
                  <td class="px-4 py-2">{{ buyer.totalPrice }}</td>
                  <td class="px-4 py-2">{{ buyer.event }}</td>
                </tr>
                <tr v-if="buyers.length === 0">
                  <td colspan="6" class="text-center text-gray-500 py-6">No buyers found.</td>
                </tr>
              </tbody>
            </table>
          </div>
        </section>
      </main>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'

definePageMeta({
  layout: 'master',
  middleware: 'org-auth'
})

const buyers = ref([])
const eventList = ref([])
const selectedEventId = ref('')

// Fetch buyers (filtered by event if selected)
const fetchBuyers = async () => {
  try {
    let url = 'http://localhost:8000/api/organization/dashboard'
    if (selectedEventId.value) {
      url += `?event_id=${selectedEventId.value}`
    }

    const response = await fetch(url, {
      method: 'GET',
      credentials: 'include', // Needed for Sanctum
    })

    const result = await response.json()

    if (response.ok && result.buyers) {
      buyers.value = result.buyers.map(buyer => ({
        date: new Date(buyer.payment_date).toLocaleDateString('en-US', {
          year: 'numeric',
          month: 'short',
          day: 'numeric',
        }),
        id: buyer.user_id,
        userName: buyer.username,
        quantity: buyer.quantity,
        totalPrice: `$${Number(buyer.amount).toFixed(2)}`,
        event: buyer.title, // Use `title` returned from Laravel
      }))
    } else {
      console.error('Error fetching buyers:', result)
      buyers.value = []
    }
  } catch (error) {
    console.error('Network error:', error)
    buyers.value = []
  }
}

// Fetch the logged-in organization's events
const fetchEventList = async () => {
  try {
    const response = await fetch('http://localhost:8000/api/organization/events', {
      credentials: 'include',
    })

    const result = await response.json()

    if (response.ok && result.events) {
      eventList.value = result.events
    } else {
      console.error('Failed to load events:', result)
    }
  } catch (error) {
    console.error('Network error while fetching events:', error)
  }
}

onMounted(() => {
  fetchEventList()
  fetchBuyers()
})
</script>

<style scoped>
/* Optional: Scoped styles */
</style>
