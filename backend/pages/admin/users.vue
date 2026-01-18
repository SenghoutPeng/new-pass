<template>
  <div class="min-h-screen bg-white p-8 font-inter antialiased">
    <div class="max-w-full mx-auto px-4">
      <!-- Header Section -->
      <div class="flex items-center justify-between mb-8">
        <div>
          <h1 class="text-4xl font-bold text-gray-900">User Management</h1>
          <p class="text-gray-600 mt-1">Manage all registered users and their account details</p>
        </div>
      </div>

      <!-- Stats Cards -->
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        <!-- Total Users -->
        <div class="bg-white rounded-lg p-6 flex items-start space-x-4 border-2 border-gray-200">
          <div class="bg-blue-500 text-blue-600 p-3 rounded-full flex-shrink-0 flex items-center justify-center">
            <!-- Icon -->
            <svg class="w-6 h-6 text-white" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 24 24">
              <path fill-rule="evenodd" d="M8 4a4 4 0 1 0 0 8 4 4 0 0 0 0-8Zm-2 9a4 4 0 0 0-4 4v1a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2v-1a4 4 0 0 0-4-4H6Zm7.25-2.095c.478-.86.75-1.85.75-2.905a5.973 5.973 0 0 0-.75-2.906 4 4 0 1 1 0 5.811ZM15.466 20c.34-.588.535-1.271.535-2v-1a5.978 5.978 0 0 0-1.528-4H18a4 4 0 0 1 4 4v1a2 2 0 0 1-2 2h-4.535Z" clip-rule="evenodd"/>
            </svg>
          </div>
          <div class="flex-grow">
            <h3 class="text-gray-500 text-sm font-medium">Total Users</h3>
            <p class="text-3xl font-semibold text-gray-900 mt-1">{{ totalUsers }}</p>
          </div>
        </div>

        <!-- Total User Balance -->
        <div class="bg-white rounded-lg p-6 flex items-start space-x-4 border-2 border-gray-200">
          <div class="bg-amber-200 text-amber-600 p-3 rounded-full flex-shrink-0 flex items-center justify-center">
            <!-- Icon -->
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
              <path stroke-linecap="round" stroke-linejoin="round" d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z"/>
            </svg>
          </div>
          <div class="flex-grow">
            <h3 class="text-gray-500 text-sm font-medium">Total User Balance</h3>
            <p class="text-3xl font-semibold text-gray-900 mt-1">{{ totalBalance }}</p>
          </div>
        </div>

        <!-- New This Month -->
        <div class="bg-white rounded-lg p-6 flex items-start space-x-4 border-2 border-gray-200">
          <div class="bg-rose-400 text-rose-600 p-3 rounded-full flex-shrink-0 flex items-center justify-center">
            <!-- Icon -->
            <svg class="w-6 h-6 text-white" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 24 24">
              <path fill-rule="evenodd" d="M9 4a4 4 0 1 0 0 8 4 4 0 0 0 0-8Zm-2 9a4 4 0 0 0-4 4v1a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2v-1a4 4 0 0 0-4-4H7Zm8-1a1 1 0 0 1 1-1h1v-1a1 1 0 1 1 2 0v1h1a1 1 0 1 1 0 2h-1v1a1 1 0 1 1-2 0v-1h-1a1 1 0 0 1-1-1Z" clip-rule="evenodd"/>
            </svg>
          </div>
          <div class="flex-grow">
            <h3 class="text-gray-500 text-sm font-medium">New This Month</h3>
            <p class="text-3xl font-semibold text-gray-900 mt-1">{{ newUsers }}</p>
          </div>
        </div>
      </div>

      <!-- Table Container -->
      <div class="min-h-screen bg-gray-100 p-6 mt-6 rounded-2xl">
        <div class="max-w-8xl mx-auto">

          <!-- Table Header -->
          <div class="mb-6">
            <h1 class="text-3xl font-bold mb-4 mt-3">All Users</h1>

            <!-- Search and Filter Bar -->
            <div class="flex justify-between items-center mb-4 flex-wrap gap-2">
              <div class="flex-grow max-w-xs">
                <!-- Search Input -->
                <label class="input input-bordered bg-white flex items-center gap-2 w-full">
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 opacity-50" fill="none"
                    viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                      d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                  </svg>
                  <input v-model="searchQuery" type="text" class="grow" placeholder="Search users..." />
                </label>
              </div>

            <div>
              <!-- Filter and Sort Buttons -->
              <select v-model="yearFilter" class="btn btn-outline btn-sm">
                <option value="all">All Years</option>
                <option
                  v-for="year in joinedYears"
                  :key="year"
                  :value="year"
                >
                  {{ year }}
                </option>
              </select>
            </div>
          </div>

          </div>

          <!-- Users Table -->
          <div class="overflow-x-auto shadow rounded-lg bg-white">
            <table class="table w-full">
              <thead>
                <tr class="text-base border-b bg-base-200 border-gray-200">
                  <th>Name</th>
                  <th>Email</th>
                  <th>Balance</th>
                  <th>Joined</th>
                  <th>Status</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="user in paginatedUsers" :key="user.user_id" class="border-b border-gray-200">
                  <td>
                    <div class="flex items-center gap-3">
                      <div class="avatar">
                        <div class="w-16 rounded-full">
                          <img :src="user.profile_image" alt="User Avatar" />
                        </div>
                      </div>
                      <div>
                        <div class="font-bold">{{ user.username }}</div>
                        <div class="text-sm opacity-50">ID: {{ user.user_id }}</div>
                      </div>
                    </div>
                  </td>
                  <td>{{ user.email }}</td>
                  <td>{{ user.balance }}</td>
                  <td>{{ new Date(user.created_at).toLocaleDateString() }}</td>
                  <td>
                    <span :class="user.status ? 'text-green-600 font-medium' : 'text-red-600 font-medium'">
                      {{ user.status ? 'Active' : 'Inactive' }}
                    </span>
                  </td>
                  <td>
                    <div class="flex gap-2">
                      <button
                        class="btn btn-sm btn-info bg-blue-600 text-white"
                        @click="openEditModal(user)"
                      >
                        Edit
                      </button>
                      <button
                        class="btn btn-sm text-white"
                        :class="user.status ? 'btn-error bg-red-600' : 'btn-success bg-green-600'"
                        @click="toggleStatus(user)"
                      >
                        {{ user.status ? 'Deactivate' : 'Activate' }}
                      </button>
                    </div>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>

          <!-- Pagination Controls -->
          <div class="flex justify-center items-center space-x-2 mt-6">
            <button
              class="btn btn-outline"
              :disabled="currentPage === 1"
              @click="currentPage--"
            >
              Previous
            </button>

            <button
            class="btn bg-gray-200 border-gray-300 "
            >
              {{ currentPage }}
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

    <!-- Edit User Modal -->
    <div
      v-if="editModalOpen"
      class="fixed inset-0 flex content items-center justify-center z-50"
    >
      <div
        class="absolute inset-0 bg-black/50 "
        @click="closeEditModal"
      ></div>

      <div class="bg-white rounded-lg shadow-lg max-w-md w-full p-6 relative">
        <button
          @click="closeEditModal"
          class="absolute top-3 right-3 text-gray-600 hover:text-gray-900"
          aria-label="Close modal"
        >
          ✕
        </button>

        <h2 class="text-xl font-bold mb-4">Edit User Profile</h2>

        <form @submit.prevent="submitEditUser" class="space-y-4">
          <div>
            <label for="username" class="block mb-1 font-semibold">Username</label>
            <input
              id="username"
              v-model="userProfile.username"
              type="text"
              class="input input-bordered w-full "
              required
            />
          </div>

          <div>
            <label for="email" class="block mb-1 font-semibold">Email</label>
            <input
              id="email"
              v-model="userProfile.email"
              type="email"
              class="input input-bordered w-full"
              required
            />
          </div>

          <div>
            <!--
            <label for="profile_image" class="block mb-1 font-semibold">Profile Image</label>
            <input
              id="profile_image"
              type="file"
              accept="image/*"
              @change="onFileChange"
            />
            <div v-if="previewUrl" class="mt-2">
              <img :src="previewUrl" alt="Preview" class="w-32 h-32 object-cover rounded-full" />
            </div>
            -->
          </div>

          <button type="submit" class="btn btn-primary w-full">Update Profile</button>
        </form>
      </div>
    </div>
  </div>
</template>


<script setup>
import { ref, computed, watch, reactive } from 'vue'
import { useSanctumClient } from '#imports'

const client = useSanctumClient()
const config = useRuntimeConfig()
definePageMeta({
  layout: 'master',
  middleware: 'admin',
})

const { data: UserData, refresh } = useLazyFetch(`${config.public.apiUrl}/admin/users`, {
  credentials: 'include',
  server: false,
  lazy: true,
})

const newUsers = computed(() => UserData.value?.new_users_this_month || 0)
const allUsers = computed(() => UserData.value?.users || [])
const totalUsers = computed(() => UserData.value?.total_users || 0)
const totalBalance = computed(() => UserData.value?.total_balance || 0)

const searchQuery = ref('')
const yearFilter = ref('all')

const joinedYears = computed(() => {
  const years = new Set()
  allUsers.value.forEach(user => {
    years.add(new Date(user.created_at).getFullYear())
  })
  return Array.from(years).sort((a, b) => b - a)
})

const filteredUsers = computed(() => {
  const query = searchQuery.value.toLowerCase()
  let users = allUsers.value.filter(user =>
    user.username.toLowerCase().includes(query) ||
    user.email.toLowerCase().includes(query) ||
    String(user.user_id).includes(query)
  )
  if (yearFilter.value !== 'all') {
    users = users.filter(user =>
      new Date(user.created_at).getFullYear() === parseInt(yearFilter.value)
    )
  }
  return users
})

const currentPage = ref(1)
const itemsPerPage = 10
const totalPages = computed(() => Math.ceil(filteredUsers.value.length / itemsPerPage))
const paginatedUsers = computed(() =>
  filteredUsers.value.slice((currentPage.value - 1) * itemsPerPage, currentPage.value * itemsPerPage)
)

watch([searchQuery, yearFilter], () => {
  currentPage.value = 1
})

const toggleStatus = async (user) => {
  const originalStatus = user.status
  user.status = !user.status
  try {
    await client(`${config.public.apiUrl}/admin/toggle/user/${user.user_id}`, {
      method: 'PATCH',
      credentials: 'include',

    })
    
    console.log(`User ${user.status ? 'activated' : 'deactivated'} successfully`)

    refresh()
  } catch (err) {
    user.status = originalStatus
    console.error('Failed to toggle user status', err)
  }
}

// EDIT MODAL STATE
const editModalOpen = ref(false)

// userProfile holds currently editing user data
const userProfile = reactive({
  user_id: null,
  username: '',
  email: '',
  profile_image: null, // File object or null
})

const previewUrl = ref('')

// Open modal and populate userProfile with clicked user data
function openEditModal(user) {
  userProfile.user_id = user.user_id
  userProfile.username = user.username
  userProfile.email = user.email
  userProfile.profile_image = null // Reset file input

  // Show preview from existing profile_image URL
  previewUrl.value = user.profile_image || ''

  editModalOpen.value = true
}

function closeEditModal() {
  editModalOpen.value = false
  previewUrl.value = ''
  userProfile.user_id = null
  userProfile.username = ''
  userProfile.email = ''
  userProfile.profile_image = null
}

// Handle file input change
function onFileChange(event) {
  const file = event.target.files[0]
  if (file) {
    userProfile.profile_image = file
    previewUrl.value = URL.createObjectURL(file)
  } else {
    userProfile.profile_image = null
    previewUrl.value = ''
  }
}

// Submit edited user data
async function submitEditUser() {
  if (!userProfile.user_id) return

  try {
    const formData = new FormData()
    formData.append('username', userProfile.username)
    formData.append('email', userProfile.email)
    if (userProfile.profile_image instanceof File) {
      formData.append('profile_image', userProfile.profile_image)
    }

    await client(`${config.public.apiUrl}/update/user/${userProfile.user_id}`, {
      method: 'POST',
      body: formData,
      credentials: 'include',

      headers: { 'X-HTTP-Method-Override': 'PUT' },
    })

    console.log('User updated successfully')
    refresh() 
    closeEditModal()
  } catch (error) {
    console.error('Failed to update user:', error)
  }
}
</script>

<style scoped>
.input {
  border: 1px solid #ccc;
  padding: 0.5rem;
  border-radius: 0.375rem;
  width: 100%;
  box-sizing: border-box;
}

.btn-primary {
  background-color: #2563eb;
  color: white;
  border: none;
  padding: 0.6rem 1.2rem;
  border-radius: 0.375rem;
  cursor: pointer;
  width: 100%;
}

.btn-primary:hover {
  background-color: #1e40af;
}
</style>
