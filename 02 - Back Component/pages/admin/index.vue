<template>
  <div class="min-h-screen bg-white py-10 px-6 font-inter antialiased">
    <div class="max-w-7xl mx-auto">

      <!-- Header -->
      <div class="text-center mb-12">
        <h1 class="text-4xl font-bold text-gray-900">Dashboard Data</h1>
        <p class="text-gray-600 mt-2 text-lg">Track performance, user engagement, and revenue insights</p>
      </div>

      <!-- Stats Cards -->
      <div class="grid grid-cols-1 md:grid-cols-4 gap-6">
        <!-- Total User -->
        <div class="stat bg-white rounded-xl shadow-lg p-6">
          <div class="stat-figure text-blue-500">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 stroke-current" fill="none"
              viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>
          </div>
          <div class="stat-title text-sm text-gray-500">Total Users</div>
          <div class="stat-value text-3xl font-semibold text-gray-900">{{ TotalUsers }}</div>
          <!--<div class="stat-desc text-green-500">↗ Jan 1st - Feb 1st</div> -->
        </div>

        <!-- Total Org -->
        <div class="stat bg-white rounded-xl shadow-lg p-6">
          <div class="stat-figure text-green-500">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 stroke-current" fill="none"
              viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                d="M12 6V4m0 2a2 2 0 100 4m0-4a2 2 0 110 4m-6 8a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4m6 6v10m6-2a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4" />
            </svg>
          </div>
          <div class="stat-title text-sm text-gray-500">Total Organization</div>
          <div class="stat-value text-3xl font-semibold text-gray-900">{{ TotalOrgs }}</div>
          <!-- <div class="stat-desc text-green-500">↗︎ 400 (22%)</div> -->
        </div>

        <!-- Total Revenue -->
        <div class="stat bg-white rounded-xl shadow-lg p-6">
          <div class="stat-figure text-red-500">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 stroke-current" fill="none"
              viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                d="M5 8h14M5 8a2 2 0 110-4h14a2 2 0 110 4M5 8v10a2 2 0 002 2h10a2 2 0 002-2V8m-9 4h4" />
            </svg>
          </div>
          <div class="stat-title text-sm text-gray-500">Total revenue</div>
          <div class="stat-value text-3xl font-semibold text-gray-900">{{ TotalRevenue }}</div>
          <!--<div class="stat-desc text-red-500">↘︎ 90 (14%)</div>-->
        </div>

        <!--Total ticket sold-->
        <div class="stat bg-white rounded-xl shadow-lg p-6">
          <div class="stat-figure text-red-500">
            <img width="50" height="50" src="https://img.icons8.com/ios/50/ticket--v1.png" alt="ticket--v1"/>
          </div>
          <div class="stat-title text-sm text-gray-500">Total Ticket Sold</div>
          <div class="stat-value text-3xl font-semibold text-gray-900">{{ TicketSold }}</div>
          <!--<div class="stat-desc text-red-500">↘︎ 90 (14%)</div> -->
        </div>


      </div>

      <!-- Top Performing Events (with gray background wrapper) -->
    <div class="bg-gray-200 rounded-xl p-6 mt-10">
      <div class="bg-white rounded-xl shadow-md p-6">
        <div class="flex justify-between items-center mb-4">
          <h2 class="text-lg font-semibold text-gray-900">Top Performing Events</h2>
        </div>

        <div v-for="(event, index) in paginatedTopEvents" :key="index" class="flex justify-between items-center py-4 first:border-t-0">
          <div class="flex items-center gap-4">
            <!-- Placeholder Icon -->
            <div class="bg-gray-100 p-2 rounded-lg">
              <svg class="w-6 h-6 text-gray-800 dark:text-black" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                <path stroke="currentColor" stroke-linecap="round" stroke-width="2" d="M4.37 7.657c2.063.528 2.396 2.806 3.202 3.87 1.07 1.413 2.075 1.228 3.192 2.644 1.805 2.289 1.312 5.705 1.312 6.705M20 15h-1a4 4 0 0 0-4 4v1M8.587 3.992c0 .822.112 1.886 1.515 2.58 1.402.693 2.918.351 2.918 2.334 0 .276 0 2.008 1.972 2.008 2.026.031 2.026-1.678 2.026-2.008 0-.65.527-.9 1.177-.9H20M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z"/>
              </svg>
            </div>
            <div>
              <p class="text-sm font-medium text-gray-900">{{ event.title }}</p>
              <p class="text-xs text-gray-500">by {{ event.org_name || 'Unknown Organizer' }}</p>
            </div>
          </div>
          <div class="text-right">
            <p class="text-sm font-semibold text-gray-900">{{ event.total_tickets_sold }} sold</p>
            <p class="text-xs text-green-500">${{ event.revenue }} revenue</p>
          </div>
        </div>
      </div>

      <!--Pagination-->
      <div v-if="totalPages > 1" class="flex justify-end mt-4 space-x-2">
        <button
          class="btn btn-outline"
          :disabled="currentPage === 1"
          @click="currentPage--"
        >
          Previous
        </button>

        <button
          v-for="page in totalPages"
          :key="page"
          @click="currentPage = page"
          :class="['btn btn-outline', currentPage === page ? 'btn-active' : '']"
        >
          {{ page }}
        </button>

        <button
          class="btn btn-outline"
          :disabled="currentPage === totalPages"
          @click="currentPage++"
        >
          Next
        </button>
      </div>
    </div>
    </div>
  </div>
</template>

<script setup>

import { onMounted, computed, ref } from 'vue'
const config = useRuntimeConfig()
definePageMeta({
    layout: 'master',
    middleware: 'admin'
})

const {
  data: DashboardData,
  refresh
} = useLazyFetch(`${config.public.apiUrl}/admin/dashboard`, {
  credentials: 'include',
  server: false,
  lazy: true
})

const TotalUsers = computed(() => DashboardData.value?.total_users || 0)
const TotalOrgs = computed(() => DashboardData.value?.total_organizations || 0)
const TicketSold = computed(() => DashboardData.value?.ticket_sold || 0)
const TotalRevenue = computed(() => DashboardData.value?.total_revenue || 0)
const TopEvent = computed(() => DashboardData.value?.top_events_by_ticket_sold || [])

const currentPage = ref(1)
const itemsPerPage = ref(6)

const startIndex = computed(() => (currentPage.value - 1) * itemsPerPage.value)
const endIndex = computed(() => startIndex.value + itemsPerPage.value)

const paginatedTopEvents = computed(() => {
  return TopEvent.value.slice(startIndex.value, endIndex.value)
})

const totalPages = computed(() => {
  return Math.ceil(TopEvent.value.length / itemsPerPage.value)
})

onMounted(() => {
  refresh()
})
</script>