<template>
  <div class="min-h-screen bg-white py-10 px-6 font-inter antialiased">
    <div class="max-w-7xl mx-auto">

      <!-- Header -->
      <div class="text-center mb-12">
        <h1 class="text-4xl font-bold text-gray-900">All Events</h1>
        <p class="text-gray-600 mt-2 text-lg">Manage all event information</p>
      </div>

      <!-- Stats Cards -->
      <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-8">
        <div class="bg-white border border-gray-200 rounded-lg shadow p-6">
          <h3 class="text-gray-500 text-sm font-medium">Total Events</h3>
          <p class="text-2xl font-bold text-gray-900">{{ stats.total_events }}</p>
        </div>
        <div class="bg-white border border-gray-200 rounded-lg shadow p-6">
          <h3 class="text-gray-500 text-sm font-medium">Approved Events</h3>
          <p class="text-2xl font-bold text-gray-900">{{ stats.total_approved_events }}</p>
        </div>
        <div class="bg-white border border-gray-200 rounded-lg shadow p-6">
          <h3 class="text-gray-500 text-sm font-medium">Upcoming Events</h3>
          <p class="text-2xl font-bold text-gray-900">{{ stats.upcoming_events.length }}</p>
        </div>
      </div>

      <!-- Search & Filter -->
      <div class="flex flex-col md:flex-row justify-between gap-4 mb-6">
        <div class="bg-white border border-gray-200 rounded-lg shadow-md p-6 w-full md:w-1/2">
          <label class="input input-bordered bg-white flex items-center gap-2 w-full border border-black rounded-md">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 opacity-50" fill="none"
              viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
            </svg>
            <input v-model="searchQuery" class="grow" type="text" placeholder="Search events..." />
          </label>
        </div>
        <div class="bg-white border border-gray-200 rounded-lg shadow-md p-6 w-full md:w-1/2">
          <select v-model="categoryFilter" class="select select-bordered w-full bg-gray-200">
            <option value="">All Categories</option>
            <option v-for="[name, id] in categories" :key="id" :value="id">{{ name }}</option>
          </select>
        </div>
      </div>

      <!-- Tabs -->
      <div class="tabs mb-6">
        <a class="tab tab-bordered" :class="{ 'tab-active': activeTab === 'all' }" @click="activeTab = 'all'">All Events</a>
        <a class="tab tab-bordered" :class="{ 'tab-active': activeTab === 'upcoming' }" @click="activeTab = 'upcoming'">Upcoming</a>
        <a class="tab tab-bordered" :class="{ 'tab-active': activeTab === 'completed' }" @click="activeTab = 'completed'">Completed</a>
      </div>

      <!-- Events Table -->
      <div class="overflow-x-auto rounded-xl border border-gray-200 mb-10">
        <table class="table w-full bg-white">
          <thead>
            <tr class="text-sm text-white bg-gray-800">
              <th class="py-3 px-4 text-left font-medium">Event Name</th>
              <th class="py-3 px-4 text-left font-medium">Category</th>
              <th class="py-3 px-4 text-left font-medium">Location</th>
              <th class="py-3 px-4 text-left font-medium">Event Dates</th>
              <th class="py-3 px-4 text-left font-medium">Status</th>
              <th class="py-3 px-4 text-left font-medium">Action</th>
            </tr>
          </thead>
          <tbody v-if="paginatedEvents.length">
            <tr v-for="event in paginatedEvents" :key="event.event_id" class="border-t border-gray-200 hover:bg-gray-50 text-sm">
              <td class="py-3 px-4 font-medium text-gray-800">{{ event.title }}</td>
              <td class="py-3 px-4 text-gray-700">{{ event.event_category_name }}</td>
              <td class="py-3 px-4 text-gray-600">{{ event.location }}</td>
              <td class="py-3 px-4 text-gray-600">
                {{ formatDate(event.first_event_day) }}
                <span v-if="event.first_event_day !== event.last_event_day">to {{ formatDate(event.last_event_day) }}</span>
              </td>
              <td class="py-3 px-4">
                <span class="badge text-xs px-2 py-1 rounded-full" :class="getStatusClass(event.status)">
                  {{ event.status }}
                </span>
              </td>
              <td class="py-3 px-4">
                <button class="btn btn-sm btn-outline mr-2" @click="viewDetails(event)">View</button>
                <button class="btn btn-sm btn-primary" @click="editEvent(event)">Edit</button>
              </td>
            </tr>
          </tbody>
          <tbody v-else>
            <tr>
              <td colspan="6" class="text-center py-6 text-gray-500">No events found</td>
            </tr>
          </tbody>
        </table>
      </div>

      <!-- Pagination -->
      <div class="flex justify-end mt-4 space-x-2">
        <button class="btn btn-outline" :disabled="currentPage === 1" @click="currentPage--">Previous</button>
        <button v-for="page in totalPages" :key="page" @click="currentPage = page" 
          :class="['btn btn-outline', currentPage === page ? 'btn-active' : '']">
          {{ page }}
        </button>
        <button class="btn btn-outline" :disabled="currentPage === totalPages" @click="currentPage++">Next</button>
      </div>
    </div>

    <!-- Loading Overlay -->
    <div v-if="loading" class="fixed inset-0 bg-black/30 flex items-center justify-center z-50">
      <span class="loading loading-spinner loading-lg text-primary"></span>
    </div>

    <!-- Event Details Modal -->
    <div v-if="selectedEvent" class="fixed inset-0 w-full h-full bg-black/50 backdrop-blur-sm flex items-center justify-center z-50 p-4">
      <div class="bg-white rounded-lg shadow-lg w-full max-w-4xl max-h-[90vh] overflow-auto relative">
        <button @click="selectedEvent = null" class="absolute top-4 right-4 btn btn-circle btn-ghost">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
          </svg>
        </button>
        
        <div class="p-6">
          <div class="flex flex-col md:flex-row gap-6 mb-6">
              <img :src="selectedEvent.banner ? `http://localhost:8000/storage/${selectedEvent.banner}` : 'https://placehold.co/600x400'"
                 class="w-full md:w-1/2 h-64 object-cover rounded-lg" alt="Event banner">
            <div>
              <h2 class="text-2xl font-bold mb-2">{{ selectedEvent.title }}</h2>
              <p class="text-gray-700 mb-1"><span class="font-semibold">Category:</span> {{ selectedEvent.event_category_name }}</p>
              <p class="text-gray-700 mb-1"><span class="font-semibold">Location:</span> {{ selectedEvent.location }}</p>
              <p class="text-gray-700 mb-4"><span class="font-semibold">Dates:</span> 
                {{ formatDate(selectedEvent.first_event_day) }}
                <span v-if="selectedEvent.first_event_day !== selectedEvent.last_event_day">
                  to {{ formatDate(selectedEvent.last_event_day) }}
                </span>
              </p>
              <span class="badge" :class="getStatusClass(selectedEvent.status)">{{ selectedEvent.status }}</span>
            </div>
          </div>
          
          <div class="mb-6">
            <h3 class="text-xl font-bold mb-2">Description</h3>
            <p class="whitespace-pre-line">{{ selectedEvent.description }}</p>
          </div>
          
          <div v-if="selectedEvent.dates?.length" class="mb-4">
            <h3 class="text-xl font-bold mb-4">Event Schedule</h3>
            <div class="overflow-x-auto">
              <table class="table">
                <thead>
                  <tr class="bg-gray-100">
                    <th>Date</th>
                    <th>Time</th>
                    <th>Ticket Price</th>
                    <th>Available Tickets</th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="date in selectedEvent.dates" :key="date.event_date_id">
                    <td>{{ formatDate(date.event_date) }}</td>
                    <td>{{ formatTime(date.event_time) }}</td>
                    <td>${{ date.ticket_price }}</td>
                    <td>{{ date.total_ticket }}</td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Edit Event Modal -->
    <div v-if="editingEvent" class="fixed inset-0 w-full h-full bg-black/50 backdrop-blur-sm flex items-center justify-center z-50 p-4">
      <div class="bg-white rounded-lg shadow-lg w-full max-w-4xl max-h-[90vh] overflow-auto relative">
        <button @click="editingEvent = null" class="absolute top-4 right-4 btn btn-circle btn-ghost">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
          </svg>
        </button>
        
        <div class="p-6">
          <h2 class="text-2xl font-bold mb-6">Edit Event</h2>
          
          <form @submit.prevent="updateEvent">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
              <div>
                <label class="label">
                  <span class="label-text">Event Title</span>
                </label>
                <input v-model="editingEvent.title" type="text" class="input input-bordered w-full bg-white" required>
                <p v-if="errors.title" class="text-error text-sm mt-1">{{ errors.title[0] }}</p>
              </div>
              
              <div>
                <label class="label">
                  <span class="label-text">Category</span>
                </label>
                <select v-model="editingEvent.event_category_id" class="select select-bordered w-full bg-white" required>
                  <option v-for="[name, id] in categories" :key="id" :value="id">{{ name }}</option>
                </select>
                <p v-if="errors.event_category_id" class="text-error text-sm mt-1">{{ errors.event_category_id[0] }}</p>
              </div>
              
              <div>
                <label class="label">
                  <span class="label-text">Location</span>
                </label>
                <input v-model="editingEvent.location" type="text" class="input input-bordered w-full bg-white" required>
                <p v-if="errors.location" class="text-error text-sm mt-1">{{ errors.location[0] }}</p>
              </div>
              
              </div>
            
            <div class="mb-6">
              <label class="label">
                <span class="label-text">Description</span>
              </label>
              <textarea v-model="editingEvent.description" class="textarea textarea-bordered w-full h-32 bg-white" required></textarea>
              <p v-if="errors.description" class="text-error text-sm mt-1">{{ errors.description[0] }}</p>
            </div>
            
            <div class="mb-6">
              <div class="flex justify-between items-center mb-4">
                <h3 class="text-xl font-bold">Event Dates</h3>
                <button v-if="editingEvent.dates.length < 3 && editingEvent.status !== 'approved'" 
                        @click="addDate" type="button" class="btn btn-sm btn-outline bg-white">
                  Add Date
                </button>
              </div>
              
              <div v-for="(date, index) in editingEvent.dates" :key="index" class="mb-4 p-4 border rounded-lg">
                <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-4">
                  <div>
                    <label class="label">
                      <span class="label-text">Date</span>
                    </label>
                    <input v-model="date.event_date" type="date" class="input input-bordered w-full bg-white"
                      :min="editingEvent.status === 'approved' ? '' : new Date().toISOString().split('T')[0]"
                      :readonly="editingEvent.status === 'approved'" required>
                    <p v-if="errors[`dates.${index}.event_date`]" class="text-error text-sm mt-1">{{ errors[`dates.${index}.event_date`][0] }}</p>
                  </div>
                  
                  <div>
                    <label class="label">
                      <span class="label-text">Time</span>
                    </label>
                    <input v-model="date.event_time" type="time" class="input input-bordered w-full bg-white"
                      :readonly="editingEvent.status === 'approved'" required>
                    <p v-if="errors[`dates.${index}.event_time`]" class="text-error text-sm mt-1">{{ errors[`dates.${index}.event_time`][0] }}</p>
                  </div>
                  
                  <div>
                    <label class="label">
                      <span class="label-text">Ticket Price ($)</span>
                    </label>
                    <input v-model="date.ticket_price" type="number" min="0" step="0.01" class="input input-bordered w-full bg-white"
                      :readonly="editingEvent.status === 'approved'" required>
                    <p v-if="errors[`dates.${index}.ticket_price`]" class="text-error text-sm mt-1">{{ errors[`dates.${index}.ticket_price`][0] }}</p>
                  </div>
                </div>
                
                <div>
                  <label class="label">
                    <span class="label-text">Total Tickets</span>
                  </label>
                  <input v-model="date.total_ticket" type="number" min="1" class="input input-bordered w-full bg-white" required>
                  <p v-if="date.original_tickets && date.total_ticket < date.original_tickets" class="text-error text-sm mt-1">
                    Cannot reduce tickets below original value: {{ date.original_tickets }}
                  </p>
                  <p v-if="errors[`dates.${index}.total_ticket`]" class="text-error text-sm mt-1">{{ errors[`dates.${index}.total_ticket`][0] }}</p>
                </div>
                
                <button v-if="editingEvent.dates.length > 1 && editingEvent.status !== 'approved'" 
                        @click="removeDate(index)" type="button" class="btn btn-error btn-sm mt-2">
                  Remove Date
                </button>
              </div>
              <p v-if="errors.dates" class="text-error text-sm mt-1">{{ errors.dates[0] }}</p>
            </div>
            
            <div class="flex justify-end gap-4">
              <button @click="editingEvent = null" type="button" class="btn btn-outline">Cancel</button>
              <button type="submit" class="btn btn-primary" :disabled="loading">
                <span v-if="loading" class="loading loading-spinner"></span>
                Save Changes
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, watch } from 'vue'
import { useSanctumClient } from '#imports'

definePageMeta({
  layout: 'master',
  middleware: 'admin'
})

// State
const allEvents = ref([])
const stats = ref({
  total_events: 0,
  total_approved_events: 0,
  upcoming_events: [],
  official_events: []
})
const categories = ref([]) // Array of [name, id] pairs
const selectedEvent = ref(null)
const editingEvent = ref(null)
const newBannerFile = ref(null)
const searchQuery = ref('')
const categoryFilter = ref('')
const currentPage = ref(1)
const itemsPerPage = ref(10)
const loading = ref(false)
const client = useSanctumClient()
const errors = ref({}); // For validation errors from backend

// Tabs
const activeTab = ref('all')

// Fetch events
const fetchEvents = async () => {
  loading.value = true
  try {
    // Ensure the correct endpoint is called for admin's all events
    const data = await client('http://localhost:8000/api/admin/events')

    // Map events to ensure banner URL is correct for display
    allEvents.value = data.events.map(event => ({
      ...event,
      banner: event.banner
    }))

    stats.value = {
      total_events: data.total_events,
      total_approved_events: data.total_approved_events,
      upcoming_events: data.upcoming_events,
      official_events: data.official_events
    }

    const categoryMap = new Map()
    data.event_category.forEach(event => {
      // Ensure event_category_id and event_category_name exist
      if (event.event_category_id && event.event_category_name) {
        categoryMap.set(event.event_category_name, event.event_category_id)
      }
    })
    categories.value = Array.from(categoryMap.entries())

  } catch (error) {
    console.error('Error loading events:', error)
    alert('Failed to load events. Please try again.')
  } finally {
    loading.value = false
  }
}



// Computed properties
const filteredEvents = computed(() => {
  let events = allEvents.value
  
  // Apply search filter
  if (searchQuery.value.trim()) {
    const query = searchQuery.value.trim().toLowerCase()
    events = events.filter(event => 
      (event.title && event.title.toLowerCase().includes(query)) ||
      (event.description && event.description.toLowerCase().includes(query)) ||
      (event.location && event.location.toLowerCase().includes(query)) ||
      (event.org_name && event.org_name.toLowerCase().includes(query)) // Search by organization name
    )
  }
  
  // Apply category filter
  if (categoryFilter.value) {
    events = events.filter(event => event.event_category_id == categoryFilter.value)
  }
  
  // Apply tab filter
  if (activeTab.value === 'upcoming') {
    const upcomingIds = stats.value.upcoming_events.map(e => e.event_id)
    events = events.filter(event => upcomingIds.includes(event.event_id))
  } else if (activeTab.value === 'completed') {
    const completedIds = stats.value.official_events.map(e => e.event_id)
    events = events.filter(event => completedIds.includes(event.event_id))
  }
  
  return events
})

const totalPages = computed(() => Math.max(1, Math.ceil(filteredEvents.value.length / itemsPerPage.value)))

const paginatedEvents = computed(() => {
  const start = (currentPage.value - 1) * itemsPerPage.value
  return filteredEvents.value.slice(start, start + itemsPerPage.value)
})

// Watchers
watch([searchQuery, categoryFilter, activeTab], () => {
  currentPage.value = 1
})

watch(totalPages, (newTotal) => {
  if (currentPage.value > newTotal) {
    currentPage.value = newTotal
  }
})

// Methods
const viewDetails = (event) => {
  selectedEvent.value = event
}

const editEvent = (event) => {
  // Create a deep copy of the event for editing
  editingEvent.value = JSON.parse(JSON.stringify(event))
  
  // Store original ticket counts for validation and format dates for input fields
  editingEvent.value.dates.forEach(date => {
    date.original_tickets = date.total_ticket
    date.event_date = date.event_date ? new Date(date.event_date).toISOString().split('T')[0] : ''
    date.event_time = date.event_time ? date.event_time.substring(0, 5) : '' // Format HH:MM
  })
  

  newBannerFile.value = null // Clear any previously selected file
  errors.value = {}; // Clear previous validation errors
}

const handleBannerUpload = (e) => {
  const file = e.target.files[0]
  if (file) {
    newBannerFile.value = file
  }
}

const clearBanner = () => {
    editingEvent.value.banner = null; // Mark for deletion on backend
    newBannerFile.value = null; // Clear any pending file
    // Reset the file input visually
    const fileInput = document.querySelector('.file-input'); // Select by class, or give it an ID
    if (fileInput) {
        fileInput.value = '';
    }
};


const addDate = () => {
  if (editingEvent.value.dates.length < 3) {
    editingEvent.value.dates.push({
      event_date_id: null, // Indicates a new date
      event_date: new Date().toISOString().split('T')[0], // Default to today
      event_time: '18:00', // Default time
      ticket_price: 0.00,
      total_ticket: 1,
      original_tickets: 0 // New dates don't have original tickets yet
    })
  } else {
    alert('An event cannot have more than 3 dates.')
  }
}

const removeDate = (index) => {
  if (editingEvent.value.dates.length > 1) { // Ensure at least one date remains
    if (confirm('Are you sure you want to remove this date?')) {
      editingEvent.value.dates.splice(index, 1)
    }
  } else {
    alert('An event must have at least one date.')
  }
}

const updateEvent = async () => {
  loading.value = true
  errors.value = {}; // Clear previous errors
  try {
    const formData = new FormData()
    
    // Append event_id to FormData (Crucial for backend to find the event)
    formData.append('event_id', editingEvent.value.event_id) // <--- ADD THIS LINE
    
    // Append main event fields
    formData.append('title', editingEvent.value.title || '')
    formData.append('description', editingEvent.value.description || '')
    formData.append('location', editingEvent.value.location || '')
    formData.append('event_category_id', editingEvent.value.event_category_id || '')
    formData.append('proposed_date', editingEvent.value.proposed_date || '')

    // Handle banner file
    if (newBannerFile.value) {
      formData.append('banner', newBannerFile.value)
    } else if (editingEvent.value.banner === null) {
      // If banner was explicitly cleared
      formData.append('banner', '')
    }
    // If banner is not changed, do not append it to formData

    // Append dates array correctly for Laravel
    editingEvent.value.dates.forEach((date, index) => {
      // Only append fields that are relevant for the given status
      if (editingEvent.value.status === 'approved') {
          // For approved, only event_date_id and total_ticket are allowed
          // We must ensure event_date_id is always present for existing dates
          if (date.event_date_id) {
              formData.append(`dates[${index}][event_date_id]`, date.event_date_id);
          }
          // total_ticket is always allowed for approved events
          formData.append(`dates[${index}][total_ticket]`, date.total_ticket);
      } else {
          // For pending/rejected, all fields are allowed
          if (date.event_date_id) {
              formData.append(`dates[${index}][event_date_id]`, date.event_date_id);
          }
          formData.append(`dates[${index}][event_date]`, date.event_date);
          formData.append(`dates[${index}][event_time]`, date.event_time);
          formData.append(`dates[${index}][ticket_price]`, date.ticket_price);
          formData.append(`dates[${index}][total_ticket]`, date.total_ticket);
      }
    })

 

    // Correct URL (NO event_id in URL anymore)
    const res = await client(`http://localhost:8000/api/admin/update/event`, { // <--- URL CHANGED
      method: 'POST', // This must be POST when using _method=PATCH with FormData
      body: formData,
      // Do NOT set Content-Type header manually for FormData
    })

    if (!res.ok) {
        const errorData = await res;
        if (res.status === 422 && errorData.errors) {
            errors.value = errorData.errors;
            alert('Validation failed. Please check your input.');
        } else {
            throw new Error(errorData.message || 'Failed to update event.');
        }
    } else {
        alert('Event updated successfully!');
        editingEvent.value = null // Close modal
        await fetchEvents() // Refresh data
    }
  } catch (e) {
    console.error('Error updating event:', e)
    alert(e.message || 'An unexpected error occurred during update.')
  } finally {
    loading.value = false
  }
}
// Helpers
const formatDate = (dateString) => {
  if (!dateString) return 'N/A'
  const options = { year: 'numeric', month: 'long', day: 'numeric' }
  return new Date(dateString).toLocaleDateString(undefined, options)
}

const formatTime = (timeString) => {
  if (!timeString) return 'N/A'
  // Ensure time is always in HH:MM format for display
  return timeString.slice(0, 5)
}

const getStatusClass = (status) => {
  const normalized = status.toLowerCase()
  switch (normalized) {
    case 'approved': return 'bg-green-100 text-green-800'
    case 'pending': return 'bg-yellow-100 text-yellow-800'
    case 'rejected': return 'bg-red-100 text-red-800'
    default: return 'bg-gray-100 text-gray-800'
  }
}

// Initialize
onMounted(() => {
  fetchEvents()
})
</script>

<style scoped>
::-webkit-scrollbar {
  width: 6px;
}

::-webkit-scrollbar-thumb {
  background-color: rgba(0, 0, 0, 0.2);
  border-radius: 3px;
}
</style>
