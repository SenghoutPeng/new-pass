<template>
  <div class="flex min-h-screen bg-gray-100">
    <div class="flex-1 flex flex-col">
      <main class="flex-1 p-8 overflow-y-auto">
        <h1 class="text-3xl font-bold text-gray-800 mb-6">Feedback Dashboard</h1>

        <!-- Summary Cards -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-2 gap-6 mb-8">
          <div class="bg-white p-6 rounded-lg shadow-md text-center">
            <p class="text-gray-600 text-sm uppercase">Overall Rating</p>
            <p class="text-3xl font-bold text-gray-900 mt-2">{{ Math.min(overallAverageRating, 5).toFixed(1) }}</p>
            <div class="flex justify-center text-yellow-400 mt-1">
              <i v-for="n in 5" :key="n" :class="getStarClass(overallAverageRating, n)"></i>
            </div>
          </div>

          <div class="bg-white p-6 rounded-lg shadow-md text-center">
            <p class="text-gray-600 text-sm uppercase">Total Ratings</p>
            <p class="text-3xl font-bold text-gray-900 mt-2">{{ totalRatings }}</p>
            <p class="text-gray-500 text-xs mt-1">Across All Categories</p>
          </div>

          <div
            v-for="(item, index) in ratingSummary"
            :key="index"
            class="bg-white p-6 rounded-lg shadow-md text-center"
          >
            <p class="text-gray-600 text-sm uppercase">{{ item.rating_category_name }}</p>
            <p class="text-3xl font-bold text-gray-900 mt-2">{{ Math.min(parseFloat(item.average_rating), 5).toFixed(1) }}</p>
            <div class="flex justify-center text-yellow-400 mt-1">
              <i v-for="n in 5" :key="n" :class="getStarClass(item.average_rating, n)"></i>
            </div>
            <p class="text-xs text-gray-500 mt-1">Total: {{ item.total_ratings }}</p>
          </div>
        </div>

        <!-- Event Filter Dropdown -->
        <div class="mb-4">
          <label class="block text-sm font-medium text-gray-700 mb-1">Filter by Event</label>
          <select
            v-model="selectedEventId"
            class="block w-full md:w-64 px-4 py-2 border border-gray-300 bg-white rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500"
          >
            <option value="">All Events</option>
            <option v-for="event in eventList" :key="event.id" :value="event.id">
              {{ event.name }}
            </option>
          </select>
        </div>

        <!-- Recent Feedback Table -->
        <section class="bg-white p-8 rounded-lg shadow-md">
          <div class="overflow-x-auto">
            <table class="min-w-full text-sm text-left whitespace-nowrap">
              <thead class="bg-gray-100">
                <tr>
                  <th class="px-4 py-2 text-gray-700">DATE</th>
                  <th class="px-4 py-2 text-gray-700">CUSTOMER ID</th>
                  <th class="px-4 py-2 text-gray-700">USERNAME</th>
                  <th class="px-4 py-2 text-gray-700">EVENT</th>
                  <th class="px-4 py-2 text-gray-700">RATING</th>
                  <th class="px-4 py-2 text-gray-700">CATEGORY</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="(item, index) in recentFeedback" :key="index" class="border-t border-gray-200">
                  <td class="px-4 py-2">{{ formatDate(item.date) }}</td>
                  <td class="px-4 py-2">#{{ item.customer_id }}</td>
                  <td class="px-4 py-2">{{ item.username }}</td>
                  <td class="px-4 py-2">{{ item.event_name }}</td>
                  <td class="px-4 py-2">
                    <div class="flex text-yellow-400">
                      <i v-for="n in 5" :key="n" :class="getStarClass(item.rating, n)"></i>
                    </div>
                  </td>
                  <td class="px-4 py-2">{{ item.rating_category_name }}</td>
                </tr>
                <tr v-if="recentFeedback.length === 0">
                  <td colspan="6" class="text-center text-gray-500 py-6">No feedback available.</td>
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
import { ref, onMounted, watch } from 'vue'

definePageMeta({
  layout: 'master',
  middleware: 'org-auth'
})

const ratingSummary = ref([])
const recentFeedback = ref([])
const overallAverageRating = ref(0)
const totalRatings = ref(0)
const config = useRuntimeConfig()
const selectedEventId = ref('')
const eventList = ref([])

const fetchFeedbackData = async () => {
  try {
    const url = selectedEventId.value
      ? `${config.public.apiUrl}/organization/feedback?event_id=${selectedEventId.value}`
      : `${config.public.apiUrl}/organization/feedback`

    const res = await fetch(url, {
      method: 'GET',
      credentials: 'include'
    })

    const data = await res.json()

    if (res.ok) {
      ratingSummary.value = data.category_ratings || []
      recentFeedback.value = data.recent_feedback || []
      totalRatings.value = data.total_ratings || 0
      overallAverageRating.value = computeOverallAverage()
    } else {
      console.error('Feedback fetch failed:', data)
    }
  } catch (err) {
    console.error('Fetch error:', err)
  }
}

const fetchEventList = async () => {
  try {
    const res = await fetch(`${config.public.apiUrl}/organization/events`, {
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

const computeOverallAverage = () => {
  const ratings = recentFeedback.value.map(r => Number(r.rating)).filter(r => !isNaN(r))
  if (ratings.length === 0) return 0
  return ratings.reduce((sum, r) => sum + r, 0) / ratings.length
}

const getStarClass = (rating, starNumber) => {
  const safeRating = Math.min(parseFloat(rating), 5)
  if (safeRating >= starNumber) return 'fas fa-star'
  else if (safeRating > starNumber - 1) return 'fas fa-star-half-alt'
  else return 'far fa-star'
}

const formatDate = (dateString) => {
  return new Date(dateString).toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'short',
    day: 'numeric'
  })
}

watch(selectedEventId, () => {
  fetchFeedbackData()
})

onMounted(() => {
  fetchEventList()
  fetchFeedbackData()
})
</script>

<style scoped>
@import url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css');
</style>
