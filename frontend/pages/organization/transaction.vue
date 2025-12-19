<template>
  <div class="flex min-h-screen bg-gray-100">
    <div class="flex-1 flex flex-col">
      <main class="flex-1 p-8 overflow-y-auto">
        <h1 class="text-3xl font-bold text-gray-800 mb-6">Transaction History</h1>
        <p class="text-gray-600 mb-8">Manage your balance and view transaction details</p>

        <!-- Overview Cards -->
        <section class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-8">
          <div class="bg-green-50 p-6 rounded-lg shadow-md">
            <p class="text-gray-700 text-lg">Total Gross Sales</p>
            <p class="text-3xl font-bold text-green-700 mt-2">${{ totalGross }}</p>
          </div>
          <div class="bg-blue-50 p-6 rounded-lg shadow-md">
            <p class="text-gray-700 text-lg">Total Net Revenue</p>
            <p class="text-3xl font-bold text-blue-700 mt-2">${{ totalNet }}</p>
          </div>
        </section>

        <!-- Transactions Table -->
        <h2 class="text-2xl font-bold text-gray-800 mb-4">Transaction Details</h2>
        <section class="bg-white p-8 rounded-lg shadow-md">

          <!-- Event Filter Dropdown -->
        <div class="mb-6 w-full md:w-64">
          <label class="block text-sm font-medium text-gray-700 mb-1">Filter by Event</label>
          <select
            v-model="selectedEventId"
            @change="fetchTransactions"
            class="block w-full px-4 py-2 border border-gray-300 bg-white rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500"
          >
            <option value="">All Events</option>
            <option v-for="event in eventList" :key="event.id" :value="event.id">
              {{ event.name }}
            </option>
          </select>
        </div>

          <div class="overflow-x-auto">
            <table class="min-w-full text-sm text-left whitespace-nowrap">
              <thead class="bg-gray-100">
                <tr>
                  <th class="px-4 py-2 text-gray-700">NAME</th>
                  <th class="px-4 py-2 text-gray-700">AMOUNT</th>
                  <th class="px-4 py-2 text-gray-700">EVENT</th>
                </tr>
              </thead>
              <tbody>
                <tr
                  v-for="(transaction, index) in transactions"
                  :key="index"
                  class="border-t border-gray-200"
                >
                  <td class="px-4 py-2">{{ transaction.user }}</td>
                  <td class="px-4 py-2">${{ parseFloat(transaction.amount).toFixed(2) }}</td>
                  <td class="px-4 py-2">{{ transaction.event }}</td>
                </tr>
                <tr v-if="transactions.length === 0">
                  <td colspan="3" class="text-center text-gray-500 py-6">No transactions found.</td>
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
  middleware: 'org-auth',
})
const config = useRuntimeConfig()
const transactions = ref([])
const totalGross = ref('0.00')
const totalNet = ref('0.00')

const eventList = ref([])
const selectedEventId = ref('')

const fetchTransactions = async () => {
  try {
    let url = `${config.public.baseUrl}/api/organization/transaction`
    if (selectedEventId.value) {
      url += `?event_id=${selectedEventId.value}`
    }

    const response = await fetch(url, {
      credentials: 'include',
    })

    const data = await response.json()

    if (response.ok && data.transactions) {
      transactions.value = data.transactions

      const gross = data.transactions.reduce(
        (sum, tx) => sum + parseFloat(tx.amount),
        0
      )
      totalGross.value = gross.toFixed(2)
      totalNet.value = (gross * 0.95).toFixed(2) // Assuming 5% net revenue
    } else {
      console.error('Error fetching transactions:', data)
      transactions.value = []
      totalGross.value = '0.00'
      totalNet.value = '0.00'
    }
  } catch (error) {
    console.error('Error fetching transactions:', error)
    transactions.value = []
    totalGross.value = '0.00'
    totalNet.value = '0.00'
  }
}

// Dummy fetch for event list - replace with your real API
const fetchEventList = async () => {
  try {
    const res = await fetch(`${config.public.baseUrl}/api/organization/events`, {
      credentials: 'include',
    })
    const data = await res.json()
    if (res.ok && data.events) {
      eventList.value = data.events
    }
  } catch (err) {
    console.error('Error fetching events:', err)
  }
}

onMounted(() => {
  fetchEventList()
  fetchTransactions()
})
</script>

<style scoped>
/* Optional font-awesome import */
@import url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css');
</style>
