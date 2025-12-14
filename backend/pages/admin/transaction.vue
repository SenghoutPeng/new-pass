<template>
  <div class="min-h-screen bg-white p-8 font-inter antialiased">
    <div class="max-w-full mx-auto px-4">

      <!-- Header -->
      <div class="text-center mb-8">
        <h1 class="text-4xl font-bold text-gray-900">Transaction</h1>
        <p class="text-gray-600 mt-1">Event Ticket Commission Tracking</p>
      </div>

      <!-- Cards -->
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-2 gap-6 mb-10">
        <div class="bg-white rounded-lg p-6 shadow-md flex items-start space-x-4 border-2 border-gray-200">
          <div class="bg-blue-400 text-blue-600 p-3 rounded-full flex-shrink-0">
            <svg class="w-6 h-6 text-white" fill="currentColor" viewBox="0 0 24 24">
              <path fill-rule="evenodd" d="M11.293 3.293a1 1 0 0 1 1.414 0l6 6 2 2a1 1 0 0 1-1.414 1.414L19 12.414V19a2 2 0 0 1-2 2h-3a1 1 0 0 1-1-1v-3h-2v3a1 1 0 0 1-1 1H7a2 2 0 0 1-2-2v-6.586l-.293.293a1 1 0 0 1-1.414-1.414l2-2 6-6Z" clip-rule="evenodd"/>
            </svg>
          </div>
          <div class="flex-grow">
            <h3 class="text-gray-500 text-sm font-medium">Total Events</h3>
            <p class="text-3xl font-semibold text-gray-900 mt-1">{{ total_event }}</p>
          </div>
        </div>

        <div class="bg-white rounded-lg p-6 shadow-md flex items-start space-x-4 border-2 border-gray-200">
          <div class="bg-green-100 text-green-600 p-3 rounded-full flex-shrink-0">
            <svg class="w-6 h-6 text-green-600" fill="none" viewBox="0 0 24 24">
              <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                d="M18.5 12A2.5 2.5 0 0 1 21 9.5V7a1 1 0 0 0-1-1H4a1 1 0 0 0-1 1v2.5a2.5 2.5 0 0 1 0 5V17a1 1 0 0 0 1 1h16a1 1 0 0 0 1-1v-2.5a2.5 2.5 0 0 1-2.5-2.5Z"/>
            </svg>
          </div>
          <div class="flex-grow">
            <h3 class="text-gray-500 text-sm font-medium">Total Ticket Sold</h3>
            <p class="text-3xl font-semibold text-black mt-1">{{ ticket_sold }}</p>
          </div>
        </div>
      </div>

      <!-- Search Input -->
      <div class="flex justify-center">
        <div class="bg-white border border-gray-200 rounded-lg shadow-md w-full max-w-md p-6">
          <label class="input input-bordered bg-white flex items-center gap-2 w-full border border-black rounded-md">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 opacity-50" fill="none"
              viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
            </svg>
            <input v-model="searchQuery" class="grow" type="text" placeholder="Search Event or Organization..." />
          </label>
        </div>
      </div>

      <!-- Transaction Table -->
      <div class="overflow-x-auto border border-gray-100 rounded-xl mt-10">
        <table class="table w-full bg-gray-100 text-sm">
          <thead class="bg-base-200 text-xs text-base-content/70 uppercase">
            <tr>
              <th class="py-3 px-4">Date</th>
              <th class="py-3 px-4">Organization</th>
              <th class="py-3 px-4">Event</th>
              <th class="py-3 px-4">Ticket Sold</th>
              <th class="py-3 px-4">Commission</th>
            </tr>
          </thead>
          <tbody>
            <tr
              v-for="(transaction, index) in paginatedTransaction"
              :key="index"
              class="border-t border-gray-300 hover:bg-white"
            >
              <td class="py-3 px-4">{{ transaction.created_at }}</td>
              <td class="py-3 px-4 font-medium text-blue-600">{{ transaction.org_name }}</td>
              <td class="py-3 px-4">{{ transaction.title }}</td>
              <td class="py-3 px-4">{{ transaction.ticketsold }}</td>
              <td class="py-3 px-4 text-green-700">${{ transaction.commission_amount }}</td>
            </tr>
          </tbody>
        </table>
      </div>

      <!-- Pagination -->
      <div class="flex justify-center items-center space-x-2 mt-4">
        <button @click="currentPage--" :disabled="currentPage <= 1" class="px-3 py-1 border rounded">Prev</button>
        <span>Page {{ currentPage }} of {{ totalPages }}</span>
        <button @click="currentPage++" :disabled="currentPage >= totalPages" class="px-3 py-1 border rounded">Next</button>
      </div>

    </div>
  </div>
</template>

<script setup>
definePageMeta({
  layout: 'master',
  middleware: 'admin'
})

const {
  data: DashboardData,
  error,
  refresh,
  pending
} = useLazyFetch('/api/admin/transaction', {
  credentials: 'include',
  server: false,
  lazy: true
})

const total_event = computed(() => DashboardData.value?.total_event || 0)
const ticket_sold = computed(() => DashboardData.value?.ticket_sold || 0)
const Transactionlist = computed(() => DashboardData.value?.transactions || [])

const currentPage = ref(1)
const perPage = ref(5)
const searchQuery = ref('')

// Search by event title or organization name
const filteredTransactions = computed(() => {
  const query = searchQuery.value.toLowerCase().trim()
  if (!query) return Transactionlist.value

  return Transactionlist.value.filter(tx =>
    (tx.title || '').toLowerCase().includes(query) ||
    (tx.org_name || '').toLowerCase().includes(query)
  )
})

const paginatedTransaction = computed(() => {
  const start = (currentPage.value - 1) * perPage.value
  return filteredTransactions.value.slice(start, start + perPage.value)
})

const totalPages = computed(() => {
  return Math.ceil(filteredTransactions.value.length / perPage.value)
})
</script>

<style scoped>
input {
  background: white;
}
</style>
