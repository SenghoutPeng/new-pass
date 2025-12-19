<template>
  <div class="min-h-screen bg-white p-8 font-inter antialiased">
    <div class="max-w-full mx-auto px-4">
      <div class="flex items-center justify-between mb-8">
        <div>
          <h1 class="text-4xl font-bold text-gray-900">Organization Management</h1>
          <p class="text-gray-600 mt-1">Manage all registered Organization and their details</p>
        </div>
      </div>

      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        <div class="bg-white rounded-lg p-6 shadow-md flex items-start space-x-4 border-2 border-gray-200">
          <div class="bg-blue-500 text-blue-600 p-3 rounded-full flex-shrink-0 flex items-center justify-center">
            <svg class="w-6 h-6 text-gray-800 dark:text-white" xmlns="http://www.w3.org/2000/svg" fill="currentColor" viewBox="0 0 24 24">
              <path fill-rule="evenodd" d="M5.535 7.677c.313-.98.687-2.023.926-2.677H17.46c.253.63.646 1.64.977 2.61.166.487.312.953.416 1.347.11.42.148.675.148.779 0 .18-.032.355-.09.515-.06.161-.144.3-.243.412-.1.111-.21.192-.324.245a.809.809 0 0 1-.686 0 1.004 1.004 0 0 1-.324-.245c-.1-.112-.183-.25-.242-.412a1.473 1.473 0 0 1-.091-.515 1 1 0 1 0-2 0 1.4 1.4 0 0 1-.333.927.896.896 0 0 1-.667.323.896.896 0 0 1-.667-.323A1.401 1.401 0 0 1 13 9.736a1 1 0 1 0-2 0 1.4 1.4 0 0 1-.333.927.896.896 0 0 1-.667.323.896.896 0 0 1-.667-.323A1.4 1.4 0 0 1 9 9.74v-.008a1 1 0 0 0-2 .003v.008a1.504 1.504 0 0 1-.18.712 1.22 1.22 0 0 1-.146.209l-.007.007a1.01 1.01 0 0 1-.325.248.82.82 0 0 1-.316.08.973.973 0 0 1-.563-.256 1.224 1.224 0 0 1-.102-.103A1.518 1.518 0 0 1 5 9.724v-.006a2.543 2.543 0 0 1 .029-.207c.024-.132.06-.296.11-.49.098-.385.237-.85.395-1.344ZM4 12.112a3.521 3.521 0 0 1-1-2.376c0-.349.098-.8.202-1.208.112-.441.264-.95.428-1.46.327-1.024.715-2.104.958-2.767A1.985 1.985 0 0 1 6.456 3h11.01c.803 0 1.539.481 1.844 1.243.258.641.67 1.697 1.019 2.72a22.3 22.3 0 0 1 .457 1.487c.114.433.214.903.214 1.286 0 .412-.072.821-.214 1.207A3.288 3.288 0 0 1 20 12.16V19a2 2 0 0 1-2 2h-6a1 1 0 0 1-1-1v-4H8v4a1 1 0 0 1-1 1H6a2 2 0 0 1-2-2v-6.888ZM13 15a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v2a1 1 0 0 1-1 1h-2a1 1 0 0 1-1-1v-2Z" clip-rule="evenodd"/>
            </svg>
          </div>
          <div class="flex-grow">
            <h3 class="text-gray-500 text-sm font-medium">Total Organizations</h3>
            <p class="text-3xl font-semibold text-gray-900 mt-1">{{ totalOrgs }}</p>
          </div>
        </div>

        <div class="bg-white rounded-lg p-6 shadow-md flex items-start space-x-4 border-2 border-gray-200">
          <div class="bg-amber-200 text-amber-600 p-3 rounded-full flex-shrink-0 flex items-center justify-center">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
              <path stroke-linecap="round" stroke-linejoin="round" d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z"/>
            </svg>
          </div>
          <div class="flex-grow">
            <h3 class="text-gray-500 text-sm font-medium">Total Organization Balance</h3>
            <p class="text-3xl font-semibold text-gray-900 mt-1">{{ totalBalance }}</p>
          </div>
        </div>

        <div class="bg-white rounded-lg p-6 shadow-md flex items-start space-x-4 border-2 border-gray-200">
          <div class="bg-rose-400 text-rose-600 p-3 rounded-full flex-shrink-0 flex items-center justify-center">
            <svg class="w-6 h-6 text-gray-800 dark:text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
              <path stroke-linecap="round" stroke-linejoin="round" d="M5 12h14m-7 7V5"/>
            </svg>
          </div>
          <div class="flex-grow">
            <h3 class="text-gray-500 text-sm font-medium">New This Month</h3>
            <p class="text-3xl font-semibold text-gray-900 mt-1">{{ newOrg }}</p>
          </div>
        </div>
      </div>

      <div class="min-h-screen bg-gray-100 p-6 mt-6 rounded-2xl">
        <div class="max-w-8xl mx-auto">
          <div class="mb-6">
            <h1 class="text-3xl text-black font-bold text-base-200 mb-4 mt-3">All Organizations</h1>

            <div class="flex justify-between items-center mb-4 flex-wrap gap-2">
              <label class="input input-bordered bg-white flex items-center gap-2 w-64">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 opacity-50" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
                </svg>
                <input v-model="searchQuery" type="text" class="grow" placeholder="Search organizations..." />
              </label>

              <div class="flex gap-2">
                <select v-model="yearFilter" class="btn btn-outline btn-sm">
                  <option value="all">All Years</option>
                  <option v-for="year in joinedYears" :key="year" :value="year">{{ year }}</option>
                </select>
              </div>
            </div>
          </div>

          <div class="overflow-x-auto shadow rounded-lg bg-white">
            <table class="table bg-white w-full">
              <thead>
                <tr class="text-base-200 border-b border-gray-200 text-gray-500">
                  <th>Name</th>
                  <th>Email</th>
                  <th>Balance</th>
                  <th>Joined</th>
                  <th>Status</th>
                  <th>More</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="org in paginatedOrgs" :key="org.org_id" class="border-b border-gray-200">
                  <td>
                    <div class="flex items-center gap-3">
                      <div class="avatar placeholder">
                        <div class="avatar">
                          <div class="w-16 rounded-full">
                            <img :src="org.profile_image" alt="Organization Avatar" />
                          </div>
                        </div>
                      </div>
                      <div>
                        <div class="font-bold">{{ org.org_name }}</div>
                        <div class="text-sm opacity-50">ID: {{ org.org_id }}</div>
                      </div>
                    </div>
                  </td>
                  <td>{{ org.email }}</td>
                  <td>{{ org.balance }}</td>
                  <td>{{ new Date(org.created_at).toLocaleDateString() }}</td>
                  <td>
                    <span :class="org.status ? 'text-green-600 font-medium' : 'text-red-500 font-medium'">
                      {{ org.status ? 'Active' : 'Inactive' }}
                    </span>
                  </td>
                  <td>
                    <div class="flex gap-2">
                      <button
                        class="btn btn-sm btn-info text-white"
                        @click="openModal(org)"
                      >
                        <svg class="w-6 h-6 text-gray-800 dark:text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                          <path stroke-linecap="round" stroke-linejoin="round" d="m21 21-3.5-3.5M17 10a7 7 0 1 1-14 0 7 7 0 0 1 14 0Z"/>
                        </svg>
                      </button>

                      <button
                        class="btn btn-sm text-white"
                        :class="org.status ? 'btn-error' : 'btn-success'"
                        @click="toggleStatus(org)"
                      >
                        {{ org.status ? 'Deactivate' : 'Activate' }}
                      </button>

                      <button
                        class="btn btn-sm btn-warning text-white"
                        @click="openEditModal(org)"
                      >
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                          <path stroke-linecap="round" stroke-linejoin="round" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
                        </svg>
                      </button>
                    </div>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>

          <div class="flex justify-end mt-4 space-x-2">
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

      <dialog id="org_modal" class="modal" ref="orgModal">
        <form method="dialog" class="modal-box bg-white rounded-lg text-dark p-6">
          <h3 class="text-lg font-bold mb-2">Organization Details</h3>
          <div v-if="selectedOrg">
            <img :src="selectedOrg.profile_image" alt="Organization Avatar" class="w-32 aspect-square object-cover rounded-full mt-4" />
            <p class="mt-4"><strong>Organization Name:</strong> {{ selectedOrg.org_name }}</p>
            <p class="mt-2"><strong>Organization Email:</strong> {{ selectedOrg.email }}</p>
            <p class="mt-2"><strong>Contact Name:</strong> {{ selectedOrg.contact_name }}</p>
            <p class="mt-2"><strong>Contact Phone:</strong> {{ selectedOrg.contact_phone }}</p>
            <p class="mt-2"><strong>Contact Email:</strong> {{ selectedOrg.contact_email }}</p>
            <p class="mt-2"><strong>Joined:</strong> {{ new Date(selectedOrg.created_at).toLocaleDateString() }}</p>
          </div>
          <div class="modal-action">
            <button class="btn btn-accent text-white">Close</button>
          </div>
        </form>
      </dialog>

      <dialog id="edit_org_modal" class="modal" ref="editOrgModal">
        <form @submit.prevent="updateOrganization" class="modal-box bg-white rounded-lg p-6">
          <h3 class="text-lg font-bold mb-4 text-gray-900">Edit Organization Profile</h3>
          <div v-if="editOrgData" class="space-y-4">
            <div>
              <label for="edit_org_name" class="block text-sm font-medium text-gray-700">Organization Name</label>
              <input type="text" id="edit_org_name" v-model="editOrgData.org_name" class="mt-1 block w-full input input-bordered bg-amber-100" />
              <p v-if="validationErrors.org_name" class="text-red-500 text-xs mt-1">{{ validationErrors.org_name[0] }}</p>
            </div>
            <div>
              <label for="edit_email" class="block text-sm font-medium text-gray-700">Organization Email</label>
              <input type="email" id="edit_email" v-model="editOrgData.email" class="mt-1 block w-full input input-bordered bg-amber-100" />
              <p v-if="validationErrors.email" class="text-red-500 text-xs mt-1">{{ validationErrors.email[0] }}</p>
            </div>
            <div>
              <label for="edit_contact_name" class="block text-sm font-medium text-gray-700">Contact Name</label>
              <input type="text" id="edit_contact_name" v-model="editOrgData.contact_name" class="mt-1 block w-full input input-bordered bg-amber-100" />
              <p v-if="validationErrors.contact_name" class="text-red-500 text-xs mt-1">{{ validationErrors.contact_name[0] }}</p>
            </div>
            <div>
              <label for="edit_contact_email" class="block text-sm font-medium text-gray-700">Contact Email</label>
              <input type="email" id="edit_contact_email" v-model="editOrgData.contact_email" class="mt-1 block w-full input input-bordered bg-amber-100" />
              <p v-if="validationErrors.contact_email" class="text-red-500 text-xs mt-1">{{ validationErrors.contact_email[0] }}</p>
            </div>
            <div>
              <label for="edit_contact_phone" class="block text-sm font-medium text-gray-700">Contact Phone</label>
              <input type="text" id="edit_contact_phone" v-model="editOrgData.contact_phone" class="mt-1 block w-full input input-bordered bg-amber-100" />
              <p v-if="validationErrors.contact_phone" class="text-red-500 text-xs mt-1">{{ validationErrors.contact_phone[0] }}</p>
            </div>
          </div>
          <div class="modal-action">
            <button type="submit" class="btn btn-primary">Update</button>
            <button type="button" class="btn" @click="closeEditModal">Cancel</button>
          </div>
        </form>
        <form method="dialog" class="modal-backdrop">
          <button @click="closeEditModal">close</button>
        </form>
      </dialog>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, watch } from 'vue'
import { useSanctumClient } from '#imports'
const config = useRuntimeConfig()
definePageMeta({
  layout: 'master',
  middleware: 'admin',
})

const client = useSanctumClient()

const { data: OrganizationData, refresh } = useLazyFetch(`${config.public.baseUrl}/api/admin/organizations`, {
  credentials: 'include',
  server: false,
  lazy: true,
})

const newOrg = computed(() => OrganizationData.value?.new_organizations_this_month || 0)
const allOrgs = computed(() => OrganizationData.value?.organizations || [])
const totalOrgs = computed(() => OrganizationData.value?.total_organizations || 0)
const totalBalance = computed(() => OrganizationData.value?.total_balance || 0)

// Search and filter state
const searchQuery = ref('')
const yearFilter = ref('all')

// Extract unique years from created_at
const joinedYears = computed(() => {
  const yearList = allOrgs.value.map(org => new Date(org.created_at).getFullYear())
  const uniqueYears = Array.from(new Set(yearList)).sort((a, b) => b - a)
  return uniqueYears
})

// Filtered organizations list
const filteredOrgs = computed(() => {
  const query = searchQuery.value.toLowerCase().trim()
  let filtered = allOrgs.value.filter(org =>
    (org.org_name || '').toLowerCase().includes(query) ||
    (org.email || '').toLowerCase().includes(query) ||
    String(org.org_id || '').includes(query)
  )
  if (yearFilter.value !== 'all') {
    filtered = filtered.filter(org =>
      new Date(org.created_at).getFullYear() === Number(yearFilter.value)
    )
  }
  return filtered
})

// Pagination
const currentPage = ref(1)
const itemsPerPage = ref(10)
const totalPages = computed(() => Math.ceil(filteredOrgs.value.length / itemsPerPage.value))
const paginatedOrgs = computed(() => {
  const start = (currentPage.value - 1) * itemsPerPage.value
  return filteredOrgs.value.slice(start, start + itemsPerPage.value)
})

// Reset page when filters change
watch([searchQuery, yearFilter], () => {
  currentPage.value = 1
})

// View Details Modal
const selectedOrg = ref(null)
const orgModal = ref(null)

function openModal(org) {
  selectedOrg.value = org
  if (orgModal.value) {
    orgModal.value.showModal()
  }
}

// Toggle organization status
const toggleStatus = async (org) => {
  const originalStatus = org.status
  org.status = !org.status
  try {
    await client(`${config.public.baseUrl}/api/admin/toggle/organization/${org.org_id}`, {
      method: 'PATCH',
      credentials: 'include',
    })
    console.log(`Organization ${org.status ? 'activated' : 'deactivated'} successfully`)
    refresh()
  } catch (err) {
    org.status = originalStatus
    console.error('Failed to toggle organization status', err)
  }
}

// Edit Organization Modal State
const editOrgModal = ref(null)
const editOrgData = ref(null)
const newProfileImage = ref(null)
const validationErrors = ref({})

function openEditModal(org) {
  selectedOrg.value = org
  editOrgData.value = { ...org } // Create a copy to avoid direct mutation
  newProfileImage.value = null // Reset image input
  validationErrors.value = {} // Clear previous errors
  if (editOrgModal.value) {
    editOrgModal.value.showModal()
  }
}

function closeEditModal() {
  if (editOrgModal.value) {
    editOrgModal.value.close()
  }
}

function handleImageUpload(event) {
  newProfileImage.value = event.target.files[0]
}

const updateOrganization = async () => {
  if (!selectedOrg.value) return

  const formData = new FormData()
  for (const key in editOrgData.value) {
    if (key !== 'profile_image') { // Don't append profile_image directly from editOrgData
      formData.append(key, editOrgData.value[key])
    }
  }

  if (newProfileImage.value) {
    formData.append('profile_image', newProfileImage.value)
  }

  formData.append('_method', 'PATCH');

  try {
    const response = await client(`${config.public.baseUrl}/api/admin/update/organization/${selectedOrg.value.org_id}`, {
      method: 'PUT',
      body: formData,
      credentials: 'include',
    })

    if (response.message) {
      alert(response.message)
    }
    closeEditModal()
    refresh()
  } catch (err) {
    console.error('Failed to update organization', err)
    if (err.response && err.response._data && err.response._data.errors) {
      validationErrors.value = err.response._data.errors
    } else {
      alert('Failed to update organization. Please try again.')
    }
  }
}
</script>
