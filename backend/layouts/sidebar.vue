<template>
  <aside class="w-64 bg-blue-950 flex flex-col py-3 h-screen relative z-30">
    
    <div class="flex items-center gap-4 mb-6 px-4 relative group">
      
      <div class="avatar relative cursor-pointer" @click="triggerFileInput">
        <div class="w-16 h-16 rounded-full border border-white text-center overflow-hidden relative group-hover:border-blue-400 transition-colors text-white ">
          <img 
            :src="previewImage || imageUrl" 
            :alt="profile.name.slice(0, 2).toLocaleUpperCase()" 
            class="w-full h-full object-cover flex justify-center items-center font-bold" 
          />
          <div class="absolute inset-0 bg-black/40 flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity">
            <Icon name="camera" class="text-white w-6 h-6" />
          </div>
        </div>
      </div>

      <input 
        type="file" 
        ref="fileInput" 
        class="hidden" 
        accept="image/*"
        @change="handleFileChange"
      />

      <div 
        class="pe-3 overflow-hidden cursor-pointer hover:bg-white/10 p-2 rounded -ml-2 transition-colors flex-1"
        @click="openEditModal"
        title="Click to edit profile"
      >
        <h2 class="font-bold text-base truncate text-white group-hover:text-blue-200">
          {{ profile.name }}
          <Icon name="pencil" class="w-3 h-3 inline ml-1 opacity-50" />
        </h2>
        <p class="text-sm text-gray-400 truncate">{{ profile.email }}</p>
      </div>
    </div>

    <hr class="mb-3 border-white">

    <ul class="flex flex-col w-full text-white"> 
      <li><NuxtLink to="/admin" active-class="active-link" class="nav-item"><Icon name="grid-2x2" class="w-5 h-5" /><span>Dashboard</span></NuxtLink></li>
      <li><NuxtLink to="/admin/events" active-class="active-link" class="nav-item"><Icon name="calendar" class="w-5 h-5" /><span>All Events</span></NuxtLink></li>
      <li><NuxtLink to="/admin/event-requests" active-class="active-link" class="nav-item"><Icon name="calendar-plus" class="w-5 h-5" /><span>Event Requests</span></NuxtLink></li>
      <li><NuxtLink to="/admin/transaction" active-class="active-link" class="nav-item"><Icon name="credit-card" class="w-5 h-5" /><span>Transaction</span></NuxtLink></li>
      <li><NuxtLink to="/admin/activity-log" active-class="active-link" class="nav-item"><Icon name="list" class="w-5 h-5" /><span>Activity Log</span></NuxtLink></li>
      <li><NuxtLink to="/admin/users" active-class="active-link" class="nav-item"><Icon name="users" class="w-5 h-5" /><span>All Users</span></NuxtLink></li>
      <li><NuxtLink to="/admin/organizations" active-class="active-link" class="nav-item"><Icon name="shield-check" class="w-5 h-5" /><span>All Organizers</span></NuxtLink></li>
    </ul>

    <div v-if="isEditing" class="fixed inset-0 bg-black/50 z-50 flex items-center justify-center p-4">
      <div class="bg-white rounded-lg shadow-xl w-full max-w-sm p-6 text-black">
        <h3 class="text-lg font-bold mb-4">Edit Profile</h3>
        
        <form @submit.prevent="updateProfile">
          <div class="mb-4">
            <label class="block text-sm font-medium text-gray-700 mb-1">Username</label>
            <input 
              v-model="editForm.username" 
              type="text" 
              class="w-full border rounded px-3 py-2 focus:ring-2 focus:ring-blue-500 outline-none"
              required
            />
          </div>

          <div class="mb-6">
            <label class="block text-sm font-medium text-gray-700 mb-1">Email</label>
            <input 
              v-model="editForm.email" 
              type="email" 
              class="w-full border rounded px-3 py-2 focus:ring-2 focus:ring-blue-500 outline-none"
              required
            />
          </div>

          <div class="flex justify-end gap-2">
            <button 
              type="button" 
              @click="isEditing = false" 
              class="px-4 py-2 text-gray-600 hover:bg-gray-100 rounded"
            >
              Cancel
            </button>
            <button 
              type="submit" 
              class="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700 flex items-center gap-2"
              :disabled="isLoading"
            >
              <span v-if="isLoading" class="loading loading-spinner loading-xs"></span>
              Save
            </button>
          </div>
        </form>
      </div>
    </div>

  </aside>
</template>

<script setup>
import { onMounted, ref, computed, reactive } from 'vue'

const config = useRuntimeConfig()
const fileInput = ref(null)
const isEditing = ref(false)
const isLoading = ref(false)
const previewImage = ref(null) // For immediate UI feedback before upload
const selectedFile = ref(null)
const client = useSanctumClient();
const profile = ref({
  name: 'Loading...',
  email: '',
  image: ''
})

// Temp state for the modal
const editForm = reactive({
  username: '',
  email: ''
})

const imageUrl = computed(() => {
  if (!profile.value.image) {
    return `${config.public.baseUrl}/storage/Admin/admin20.png`;
  }

  if (profile.value.image.startsWith('http')) {
    if (!profile.value.image.includes('/storage/')) {
       return profile.value.image.replace(
         `${config.public.baseUrl}/`, 
         `${config.public.baseUrl}/storage/`
       );
    }
    return profile.value.image;
  }

  // 2. If it's just a path (e.g. "Admin/photo.jpg")
  return `${config.public.baseUrl}/storage/${profile.value.image}`;
})

// --- 1. Load Profile ---
const fetchProfile = async () => {
  try {
    const adminToken = localStorage.getItem('admin_token')
    if (!adminToken) return

    const res = await $fetch(`${config.public.apiUrl}/admin/profile`, {
      method: 'GET',
      headers: {
        'Authorization': `Bearer ${adminToken}`,
        'Accept': 'application/json'
      },
    })

    if (res && res.admin_information) {
      updateLocalProfile(res.admin_information)
    }
  } catch (error) {
    console.error('Failed to fetch profile:', error)
    if (error.response?.status === 401) handleLogout()
  }
}

// --- 2. Handle Image Upload ---
const triggerFileInput = () => {
  fileInput.value.click()
}

const handleFileChange = async (event) => {
  const file = event.target.files[0]
  if (!file) return

  // Create preview
  previewImage.value = URL.createObjectURL(file)
  selectedFile.value = file

  await uploadImageOnly(file)
}

const uploadImageOnly = async (file) => {
  const formData = new FormData()
  formData.append('profile_image', file)
  
  
  await sendUpdate(formData)
}

// ---  Handle Text Update ---
const openEditModal = () => {
  editForm.username = profile.value.name
  editForm.email = profile.value.email
  isEditing.value = true
}

const updateProfile = async () => {
  const formData = new FormData()
  formData.append('username', editForm.username)
  formData.append('email', editForm.email)
  
  await sendUpdate(formData)
  isEditing.value = false
}


const sendUpdate = async (formData) => {
  isLoading.value = true
  try {
    const adminToken = localStorage.getItem('admin_token')
    
    const res = await client(`${config.public.apiUrl}/admin/update`, {
      method: 'POST', 
      headers: {
        'Authorization': `Bearer ${adminToken}`,
      },
      body: formData
    })

    if (res.admin_information) {
      updateLocalProfile(res.admin_information)
    }
  } catch (error) {
    console.error('Update failed:', error)
    alert('Failed to update profile. ' + (error.data?.message || ''))
  } finally {
    isLoading.value = false
  }
}

const updateLocalProfile = (data) => {
  profile.value.name = data.username || 'Admin'
  profile.value.email = data.email || 'No Email'
  profile.value.image = data.profile_image || ''
  previewImage.value = null 
}

const handleLogout = () => {
  localStorage.removeItem('admin_token')
  localStorage.removeItem('admin_email')
  navigateTo('/login') // Assuming you have a login route
}

onMounted(() => {
  fetchProfile()
})
</script>

<style scoped>
.nav-item {
  display: flex;
  justify-content: flex-start; 
  text-align: left;
  gap: 12px;
  padding: 12px 24px;
  width: 100%;
  transition: all 0.2s ease-in-out;
  color: #d1d5db;
}

.nav-item:hover {
  background-color: rgba(255, 255, 255, 0.05);
  color: white;
}
.active-link {
  background-color: rgba(255, 255, 255, 0.15); 
  color: #ffffff;
  font-weight: 600;
}
</style>