<template>
  <div class="min-h-screen bg-white p-8">
    <div class="bg-gray-100 rounded-xl shadow px-6 py-6">
      <div class="flex flex-col md:flex-row justify-between items-start md:items-center mb-6 gap-4">
        <h1 class="text-2xl font-bold text-gray-800">All Event Requests</h1>
        <div class="flex gap-3 w-full md:w-auto">
          <input 
            type="text" 
            v-model="searchQuery"
            placeholder="Search events..."
            class="input input-bordered w-full md:w-64"
          />
          <select v-model="statusFilter" class="select select-bordered w-40 bg-white">
            <option value="All">All Status</option>
            <option value="Pending">Pending</option>
            <option value="Rejected">Rejected</option>
          </select>
        </div>
      </div>

      <div class="overflow-x-auto rounded-xl border border-gray-200">
        <table class="table w-full bg-white">
          <thead>
            <tr class="text-sm text-base bg-base-200">
              <th class="py-3 px-4 text-left font-medium">Organizer</th>
              <th class="py-3 px-4 text-left font-medium">Event Name</th>
              <th class="py-3 px-4 text-left font-medium">Submit Date</th>
              <th class="py-3 px-4 text-left font-medium">Status</th>
              <th class="py-3 px-4 text-left font-medium">Action</th>
            </tr>
          </thead>
          <tbody>
            <tr 
              v-for="request in filteredRequests" 
              :key="request.event_id" 
              class="border-t border-gray-200 hover:bg-gray-50 text-sm"
            >
              <td class="py-3 px-4 font-medium text-gray-800">{{ request.org_name }}</td>
              <td class="py-3 px-4 text-gray-700">{{ request.title }}</td>
              <td class="py-3 px-4 text-gray-600">{{ request.created_at }}</td>
              <td class="py-3 px-4">
                <span
                  class="badge text-xs px-2 py-1 rounded"
                  :class="getStatusClass(request.status)"
                >
                  {{ request.status }}
                </span>
              </td>
              <td class="py-3 px-4">
                <button class="btn btn-sm btn-outline" @click="viewDetails(request.event_id)">View</button>
              </td>
            </tr>
          </tbody>

        </table>
      </div>

      <div v-if="selectedEvent" class="mt-8 p-6 bg-gray-50 rounded-xl border border-gray-200">
        <h2 class="text-xl font-semibold text-gray-800 mb-4">Event Details:</h2>
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
          <div class="space-y-3 text-gray-700 text-sm">
            <p><strong>Title:</strong> {{ selectedEvent.title }}</p>
            <p><strong>Description:</strong> {{ selectedEvent.description }}</p>
            <p><strong>Date:</strong> {{ selectedEvent.created_at }}</p>
            <p><strong>Location:</strong> {{ selectedEvent.location }}</p>
            <div class="mt-4 flex gap-2">
              <button class="btn btn-success btn-sm text-white font-bold bg-green-600 hover:bg-green-700" @click="submitDecision('approved')">Approve</button>
              <button class="btn btn-error btn-sm text-white font-bold bg-red-600 hover:bg-red-700" @click="submitDecision('rejected')">Reject</button>
            </div>
          </div>

          <div class="h-[400px] w-full rounded-xl overflow-hidden bg-gray-200">
            <img
              v-if="selectedEvent.banner_url"
              :src="selectedEvent.banner_url"
              alt="Event Banner"
              class="w-full h-full object-cover"
            />
            <div v-else class="h-full flex items-center justify-center text-gray-500 text-sm">
              No banner available
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
const config = useRuntimeConfig()
definePageMeta({
  layout: 'master',
  middleware: 'admin'
})

const router = useRouter()

const searchQuery = ref('')
const statusFilter = ref('All')
const eventRequests = ref([])
const selectedEvent = ref(null)

const getCookie = (name) => {
  const value = `; ${document.cookie}`;
  const parts = value.split(`; ${name}=`);
  if (parts.length === 2) return parts.pop().split(';').shift();
  return null;
};

const getSanctumCsrfToken = () => {
  const xsrfToken = getCookie('XSRF-TOKEN');
  return xsrfToken ? decodeURIComponent(xsrfToken) : null;
};

const fetchEventRequests = async () => {
  try {
    const res = await fetch(`${config.public.apiUrl}/admin/event-requests`, {
      credentials: 'include'
    })
    const data = await res.json()
    eventRequests.value = data.event_requests
  } catch (error) {
    console.error("Error loading event requests:", error)
  }
}

const viewDetails = async (event_id) => {
  try {
    const res = await fetch(`${config.public.apiUrl}/admin/detail-event-request/${event_id}`, {
      credentials: 'include'
    })
    const data = await res.json()
    selectedEvent.value = data.event_request_detail;
  } catch (error) {
    console.error("Error fetching event detail:", error)
  }
}

const submitDecision = async (decision) => {
  try {
    await fetch('/sanctum/csrf-cookie', {
      credentials: 'include'
    });

    const xsrfToken = getSanctumCsrfToken();
    if (!xsrfToken) return router.push('/admin/login');

    const response = await fetch(`${config.public.apiUrl}/admin/approve-event`, {
      method: 'POST',
      credentials: 'include',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-XSRF-TOKEN': xsrfToken
      },
      body: JSON.stringify({
        id: selectedEvent.value.event_id,
        status: decision
      })
    });

    if (!response.ok) {
      const data = await response.json();
      throw new Error(data.message || 'Failed to submit decision.')
    }

    await fetchEventRequests()
    selectedEvent.value = null
  } catch (e) {
    console.error('Failed to update status:', e);
  }
};

const getStatusClass = (status) => {
  const normalize = status.toLowerCase()
  return normalize === 'pending'
    ? 'bg-yellow-100 text-yellow-800'
    : normalize === 'approved'
    ? 'bg-green-100 text-green-800'
    : normalize === 'rejected'
    ? 'bg-red-100 text-red-800'
    : 'bg-gray-100 text-gray-800'
}

const filteredRequests = computed(() => {
  return eventRequests.value
    .filter(r => r.status.toLowerCase() !== 'approved')
    .filter(r => {
      const matchesStatus = statusFilter.value === 'All' || r.status.toLowerCase() === statusFilter.value.toLowerCase();
      const matchesSearch = r.title.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
                            r.org_name.toLowerCase().includes(searchQuery.value.toLowerCase());
      return matchesStatus && matchesSearch;
    });
})

onMounted(async () => {
  try {
    await fetch(`${config.public.baseUrl}/sanctum/csrf-cookie`, { credentials: 'include' });
  } catch (error) {
    console.error('Error requesting CSRF cookie on mount:', error);
  }
  fetchEventRequests();
})
</script>

<style scoped>
input {
  background: white;
}
</style>