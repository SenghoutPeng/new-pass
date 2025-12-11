<template>
  <header class="bg-white shadow-md">
    <div :class="{'max-w-7xl mx-auto': !isOrganzation,'mx-7': isOrganzation }">
      <div class="flex justify-between h-16 items-center">
      <!-- Logo -->
      <NuxtLink to="/" class="flex items-center space-x-2">
        <div class="w-8 h-8 bg-blue-500 rounded-full flex items-center justify-center">
          <span class="text-white font-bold text-sm">N</span>
        </div>
        <span class="font-bold text-lg text-gray-900">NEWPASS</span>
      </NuxtLink>

      <!-- Navigation -->
        <nav class="ml-auto flex items-center space-x-8">
        <NuxtLink to="/" class="text-gray-600 hover:text-gray-900 font-medium">Home</NuxtLink>
        <NuxtLink to="/about" class="text-gray-600 hover:text-gray-900 font-medium">About Us</NuxtLink>
        <NuxtLink to="/events" class="text-gray-600 hover:text-gray-900 font-medium">Events</NuxtLink>

          <!-- Conditional User Dropdown -->
          <div v-if="user" class="relative" ref="dropdownRef">
            <button @click="toggleDropdown" class="flex items-center space-x-2 focus:outline-none">
              <div class="w-14 h-14 rounded-full overflow-hidden border border-gray-300">
                <img
                  :src="profileImage"
                  alt="Profile"
                  class="w-full h-full object-cover object-center"
            />
              </div>
          </button>

            <!-- Dropdown Menu -->
            <div
              v-if="showDropdown"
              class="absolute right-0 mt-2 w-48 bg-white rounded-lg shadow-md z-50"
            >
            <NuxtLink
                :to="redirectProfile"
              class="block px-4 py-2 text-gray-700 hover:bg-gray-100"
            >
              Profile
            </NuxtLink>
            <button
              @click="handleLogout"
                class="w-full text-left px-4 py-2 text-gray-700 hover:bg-gray-100"
            >
              Logout
            </button>
          </div>
        </div>

          <!-- Show Sign In if not logged in -->
          <div v-else>
            <NuxtLink
              to="/login"
              class="bg-blue-600 hover:bg-blue-700 text-white font-medium px-4 py-2 rounded-md transition"
            >
            Sign In
            </NuxtLink>
        </div>
      </nav>
      </div>
    </div>
  </header>
</template>

<script setup>
import { ref, computed, watchEffect } from 'vue'
import { useRouter , useRoute} from 'vue-router'
import { onClickOutside } from '@vueuse/core'

// Get user/organization information
const user = useSanctumUser()
// Use logout from SanctumAuth
const { logout } = useSanctumAuth()
const client = useSanctumClient()
const config = useRuntimeConfig()
const profile = ref(null)
const showDropdown = ref(false)
const dropdownRef = ref(null)
const router = useRouter()
const route = useRoute()

const isOrganzation = computed(() => route.path.startsWith('/organization'))

const userType = computed(() => {
  if (user.value) {
    return user.value.type;
  }
  return null;
});

onClickOutside(dropdownRef, () => {
  showDropdown.value = false
})

const redirectProfile = computed(() =>
  userType.value === 'organization' ? '/organization/profile' : '/profile'
)
const toggleDropdown = () => {
  showDropdown.value = !showDropdown.value
}

const afterLogout = computed(() =>
  userType.value === 'organization' ? '/organization/login' : '/login'
)

const profileImage = computed(() => {
  if (userType.value === 'organization') {
    return profile.value?.profile_image
      ? `${profile.value.profile_image}`
      : `${config.public.baseUrl}/storage/Organization/default.png`;
  }
  else if (userType.value === 'user' || userType.value == null) {
    return profile.value?.profile_image
      ? `${profile.value.profile_image}`
      : `${config.public.baseUrl}/storage/User/default.png`;
  }
});


const handleLogout = async () => {
  try {
    await logout()
      localStorage.removeItem('user_token')
      localStorage.removeItem('org_token')
      localStorage.removeItem('org_email')
      localStorage.removeItem('admin_token')
      localStorage.removeItem('admin_email')
    router.push('/')
  } catch (e) {
    console.error('Logout failed:', e)
  }
}



watchEffect(async () => {
  if (user.value) {
    try {
      const endpoint =
        userType.value === 'organization'
          ? '/organization/profile'
          : '/profile'

      const res = await client(`${config.public.apiUrl}${endpoint}`, {
        credentials: 'include'
      })

      profile.value =
        res?.user_information ?? res?.organization_information ?? null
    } catch (e) {
      console.error('Failed to load user profile:', e)
    }
  }
})

</script>


