<template>
  <aside class="w-auto h-full bg-white shadow-md flex flex-col justify-between py-6">
    <div>
      <div class="px-6 mb-8 text-center flex gap-4">
        <div class="w-16 h-16 rounded-full overflow-hidden border border-gray-300 mx-auto mb-2">
            <img
                :src="profileImage"
                :alt="orgInfo.org_name.slice(0, 2).toLocaleUpperCase()"
                class="w-full h-full object-cover object-center"
            />
        </div>
        <div>
        <p class="text-start text-lg font-semibold text-gray-800">{{ orgInfo.org_name || 'Organization' }}</p>
        <p class="text-start text-sm text-gray-500">{{ orgInfo.email || "organization@gmail.com" }}</p>
      </div>
         </div>
         <nav class="space-y-2 px-4">
         <NuxtLink
          v-for="item in navItems"
          :key="item.to"
          :to="item.to"
          class="flex items-center px-4 py-2 rounded-lg transition-colors duration-200"
          :class="isActive(item.to) ? 'bg-indigo-50 text-indigo-600 font-semibold' : 'text-gray-700 hover:bg-indigo-50 hover:text-indigo-600'"
        >
          <span class="mr-3 text-xl"><i :class="item.icon"></i></span> {{ item.label }}
        </NuxtLink>
      </nav>
    </div>
  </aside>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'

const route = useRoute()

// Reactive variable to store organization info
const orgInfo = ref({
  profile_image: '/storage/Organization/default.png',
  org_name: 'Organization',
  email: ''
})
const profileImage = computed(() => {
  return orgInfo.value.profile_image
})
const navItems = [
  { to: '/organization/', label: 'Dashboard', icon: 'fas fa-th-large' },
  { to: '/organization/feedback', label: 'Feedback', icon: 'fas fa-comment-alt' },
  { to: '/organization/transaction', label: 'Transaction', icon: 'fas fa-exchange-alt' },
  { to: '/organization/create-event', label: 'Create event', icon: 'fas fa-plus-square' },
  { to: '/organization/check-in', label: 'Check-in', icon: 'fas fa-user-check' },
]

const isActive = (path) => route.path === path

const fetchProfileData = async () => {
  try {
    const res = await fetch('http://localhost:8000/api/organization/profile', {
      method: 'GET',
      credentials: 'include',
      headers: {
        'Accept': 'application/json'
      }
    });

    if (!res.ok) {
      const errorData = await res.json();
      throw new Error(errorData.message || 'Failed to fetch organization profile.');
    }

    const data = await res.json();
    if (data.organization_information) {
      orgInfo.value = {
        profile_image: data.organization_information.profile_image,
        org_name: data.organization_information.org_name || 'Organization',
        email : data.organization_information.email || ''
      };
    }
  } catch (error) {
    console.error('Error fetching organization profile:', error.message);
  }
}
console.log(orgInfo.value.profile_image)
onMounted(() => {
  fetchProfileData();
})

const handleSignOut = () => {
  console.log('Signing out...');
}
</script>

<style scoped>
/* Any specific styles for the sidebar can go here */
</style>
