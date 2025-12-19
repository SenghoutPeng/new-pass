<template>
  <div class="flex min-h-screen bg-gray-100" :class="{ 'blur-background': showPasswordModal }">
    <div class="flex-1 flex flex-col">
      <main class="flex-1 p-8 overflow-y-auto">
        <h1 class="text-3xl font-bold text-gray-800 mb-6">Organization Profile</h1>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-8">
          <div class="bg-white p-6 rounded-lg shadow-md">
            <p class="text-gray-600">Your Balance</p>
            <button @click="goToRecharge" class="text-2xl font-bold text-blue-600 hover:underline mt-1">
              ${{ orgBalance.toFixed(2) }}
            </button>
          </div>
          <div class="bg-white p-6 rounded-lg shadow-md">
            <p class="text-gray-600">Total Event Created</p>
            <p class="text-2xl font-bold text-amber-700 mt-1">{{ org.total_events_created }}</p>
          </div>
        </div>

        <section class="bg-white p-8 rounded-lg shadow-md mb-8">
          <div class="flex items-center mb-6">
            <div
              class="w-16 h-16 rounded-full overflow-hidden border border-gray-300 mr-4 cursor-pointer"
              @click="triggerImageUpload"
            >
              <img
                :src="org.profile_image"
                alt="Organization Profile"
                class="w-full h-full object-cover object-center"
              />
              <input
                ref="fileInput"
                type="file"
                accept="image/*"
                class="hidden"
                @change="onFileChange"
              />
            </div>
            <div>
              <p class="text-lg font-semibold text-gray-900">{{ org.org_name }}</p>
              <p class="text-gray-600">{{ org.email }}</p>
            </div>
          </div>

          <div class="grid grid-cols-1 md:grid-cols-2 gap-y-4 gap-x-8">
            <div>
              <label for="orgId" class="block text-sm font-medium text-gray-700">ID:</label>
              <input type="text" id="orgId" v-model="org.org_id" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm bg-gray-50 sm:text-sm" readonly>
            </div>
            <div>
              <label for="orgName" class="block text-sm font-medium text-gray-700">Organization Name:</label>
              <input type="text" id="orgName" v-model="org.org_name" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
            </div>
            <div>
              <label for="orgEmail" class="block text-sm font-medium text-gray-700">Organization Email:</label>
              <input type="email" id="orgEmail" v-model="org.email" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
            </div>
            <div class="flex items-end gap-2">
              <div class="w-full">
                <label for="orgPassword" class="block text-sm font-medium text-gray-700">Password:</label>
                <input type="password" id="orgPassword" v-model="org.password" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm sm:text-sm" placeholder="********">
              </div>
              <button @click="showPasswordModal = true" class="px-4 py-2 bg-blue-500 text-white rounded-md hover:bg-blue-600 text-sm self-end">
                Change
              </button>
            </div>
            <div>
              <label for="contactName" class="block text-sm font-medium text-gray-700">Contact Name:</label>
              <input type="text" id="contactName" v-model="org.contact_name" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm sm:text-sm">
            </div>
            <div>
              <label for="contactEmail" class="block text-sm font-medium text-gray-700">Contact Email:</label>
              <input type="email" id="contactEmail" v-model="org.contact_email" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm sm:text-sm">
            </div>
            <div>
              <label for="contactPhone" class="block text-sm font-medium text-gray-700">Contact Phone:</label>
              <input type="text" id="contactPhone" v-model="org.contact_phone" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm sm:text-sm">
            </div>
          </div>

          <div class="mt-6 flex space-x-4">
            <button @click="handleSaveChanges" class="w-full bg-blue-500 text-white py-2 rounded-md hover:bg-blue-600">Save Changes</button>
          </div>
        </section>

        <div v-if="showPasswordModal" class="fixed inset-0 bg-gray-200 bg-opacity-30 flex items-center justify-center z-50">
          <div class="bg-white rounded-lg shadow-lg w-full max-w-md p-6">
            <h2 class="text-xl font-semibold text-gray-800 mb-4">Change Password</h2>

            <div class="space-y-4">
              <div class="relative">
                <label class="block text-sm font-medium text-gray-700">Old Password</label>
                <input
                  :type="oldPasswordVisible ? 'text' : 'password'"
                  v-model="oldPassword"
                  class="mt-1 block w-full border border-gray-300 rounded-md px-3 py-2 shadow-sm pr-10 sm:text-sm"
                />
                <span
                  class="absolute inset-y-0 right-0 pr-3 flex items-center pt-6 cursor-pointer text-gray-500"
                  @click="togglePasswordVisibility('old')"
                >
                  <i :class="oldPasswordVisible ? 'fas fa-eye' : 'fas fa-eye-slash'"></i>
                </span>
              </div>
              <div class="relative">
                <label class="block text-sm font-medium text-gray-700">New Password</label>
                <input
                  :type="newPasswordVisible ? 'text' : 'password'"
                  v-model="newPassword"
                  class="mt-1 block w-full border border-gray-300 rounded-md px-3 py-2 shadow-sm pr-10 sm:text-sm"
                />
                <span
                  class="absolute inset-y-0 right-0 pr-3 flex items-center pt-6 cursor-pointer text-gray-500"
                  @click="togglePasswordVisibility('new')"
                >
                  <i :class="newPasswordVisible ? 'fas fa-eye' : 'fas fa-eye-slash'"></i>
                </span>
              </div>
              <div class="relative">
                <label class="block text-sm font-medium text-gray-700">Confirm Password</label>
                <input
                  :type="confirmPasswordVisible ? 'text' : 'password'"
                  v-model="confirmPassword"
                  class="mt-1 block w-full border border-gray-300 rounded-md px-3 py-2 shadow-sm pr-10 sm:text-sm"
                />
                <span
                  class="absolute inset-y-0 right-0 pr-3 flex items-center pt-6 cursor-pointer text-gray-500"
                  @click="togglePasswordVisibility('confirm')"
                >
                  <i :class="confirmPasswordVisible ? 'fas fa-eye' : 'fas fa-eye-slash'"></i>
                </span>
              </div>
            </div>


            <div class="mt-6 flex justify-end space-x-3">
              <button @click="showPasswordModal = false" class="bg-gray-200 text-gray-700 px-4 py-2 rounded-md hover:bg-gray-300">
                Cancel
              </button>
              <button @click="handleChangePassword" class="bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700">
                Change
              </button>
            </div>
          </div>
        </div>



      </main>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { useState } from '#app'

definePageMeta({
  layout: 'master',
  middleware: 'org-auth'
})

const router = useRouter()
const client = useSanctumClient()
const config = useRuntimeConfig()
const org = ref({
  org_id: '',
  org_name: '',
  email: '',
  password: '',
  contact_name: '',
  contact_email: '',
  contact_phone: '',
  profile_image: ''
})

const profileImageFile = ref(null)
const fileInput = ref(null)

const orgBalance = useState('orgBalance', () => 0.00)


const fetchOrgProfile = async () => {
  try {
    const res = await fetch(`${config.public.baseUrl}/api/organization/profile`, {
      method: 'GET',
      credentials: 'include',
      headers: {
        Accept: 'application/json'
      }
    })

    if (!res.ok) throw new Error('Failed to fetch organization profile.')

    const data = await res.json()
    const orgData = data.organization_information

    org.value = {
      org_id: orgData.org_id,
      org_name: orgData.org_name,
      email: orgData.email,
      password: '',
      contact_name: orgData.contact_name,
      contact_email: orgData.contact_email,
      contact_phone: orgData.contact_phone,
      profile_image: orgData.profile_image,
      total_events_created: data.total_events_created || 0
    }

    orgBalance.value = parseFloat(orgData.balance)
  } catch (err) {
    console.error('Error fetching organization data:', err)
    org.value.profile_image = '';
  }
}

const triggerImageUpload = () => {
  fileInput.value.click()
}

const onFileChange = (e) => {
  const file = e.target.files[0]
  if (file) {
    profileImageFile.value = file
    org.value.profile_image = URL.createObjectURL(file)
  }
}

const handleSaveChanges = async () => {
  try {
    const formData = new FormData()
    formData.append('org_name', org.value.org_name)
    formData.append('email', org.value.email)
    formData.append('contact_name', org.value.contact_name)
    formData.append('contact_email', org.value.contact_email)
    formData.append('contact_phone', org.value.contact_phone)

    if (profileImageFile.value) {
      formData.append('profile_image', profileImageFile.value)
    }

    const data = await client('http://localhost:8000/api/organization/update', {
      method: 'POST',
      body: formData,
      credentials: 'include',
    })

    alert('Profile updated successfully.')
    window.location.reload()
    await fetchOrgProfile()
  } catch (err) {
    const message = err?.response?._data?.message || 'Failed to update profile.'
    alert('Error: ' + message)
    console.error(err)
  }
}

const showPasswordModal = ref(false)
const oldPassword = ref('')
const newPassword = ref('')
const confirmPassword = ref('')

const oldPasswordVisible = ref(false)
const newPasswordVisible = ref(false)
const confirmPasswordVisible = ref(false)

const togglePasswordVisibility = (field) => {
  if (field === 'old') {
    oldPasswordVisible.value = !oldPasswordVisible.value
  } else if (field === 'new') {
    newPasswordVisible.value = !newPasswordVisible.value
  } else if (field === 'confirm') {
    confirmPasswordVisible.value = !confirmPasswordVisible.value
  }
}

const handleChangePassword = async () => {
  if (!oldPassword.value || !newPassword.value || !confirmPassword.value) {
    alert('Please fill in all password fields.')
    return
  }

  if (newPassword.value !== confirmPassword.value) {
    alert('New passwords do not match.')
    return
  }

  try {
    const response = await client('http://localhost:8000/api/organization/change-password', {
      method: 'POST',
      body: JSON.stringify({
        current_password: oldPassword.value,
        password: newPassword.value,
        password_confirmation: confirmPassword.value
      }),
      headers: {
        'Content-Type': 'application/json'
      },
      credentials: 'include'
    })

    if (response.ok) {
      alert('Password changed successfully.')
      showPasswordModal.value = false
      oldPassword.value = ''
      newPassword.value = ''
      confirmPassword.value = ''
      oldPasswordVisible.value = false
      newPasswordVisible.value = false
      confirmPasswordVisible.value = false
    } else {
      const errorData = await response
      const message = errorData?.message || 'Failed to change password.'
      alert('Error: ' + message)
      console.error(errorData)
    }
  } catch (err) {
    const message = err?.response?._data?.message || 'Failed to change password.'
    alert('Error: ' + message)
    console.error(err)
  }
}

const getStatusClass = (status) => {
  return status === 'COMPLETED'
    ? 'bg-green-100 text-green-800'
    : 'bg-yellow-100 text-yellow-800'
}

onMounted(fetchOrgProfile)
</script>

<style scoped>
@import url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css');

</style>
