<template>
  <aside class="w-auto bg-white p-4 flex flex-col shadow-md">
    <!-- User Profile -->
    <div class="flex items-center gap-4 mb-6">
      <div class="avatar">
        <div class="w-16 h-16 shadow-black rounded-full text-center">
          <img :src="imageUrl" :alt="profile.name.slice(0, 2).toLocaleUpperCase()" class="w-full h-full rounded-full object-cover flex items-center justify-center" />
        </div>
      </div>
      <div>
        <h2 class="font-bold text-base text-black">{{ profile.name }}</h2>
        <p class="text-sm text-gray-500">{{ profile.email }}</p>
      </div>
    </div>

    <!-- Menu -->
    <ul class="menu bg-content rounded-box flex-1 text-black ">
      <li class="mb-2">
        <NuxtLink to="/admin" active-class="active">
          <Icon name="grid-2x2" />
          Dashboard
        </NuxtLink>
      </li>
      <li class="mb-2">
        <NuxtLink to="/admin/events" active-class="active">
          <Icon name="grid-2x2" />
          All Events
        </NuxtLink>
      </li>
      <li class="mb-2">
        <NuxtLink to="/admin/event-requests" active-class="active">
          <Icon name="calendar-plus" />
          Event Requests
        </NuxtLink>
      </li>
      <li class="mb-2">
        <NuxtLink to="/admin/transaction" active-class="active">
          <Icon name="credit-card" />
          Transaction
        </NuxtLink>
      </li>
      <li class="mb-2">
        <NuxtLink to="/admin/activity-log" active-class="active">
          <Icon name="list" />
          Activity Log
        </NuxtLink>
      </li>
      <li class="mb-2">
        <NuxtLink to="/admin/users" active-class="active">
          <Icon name="users" />
          All Users
        </NuxtLink>
      </li>
      <li class="mb-2">
        <NuxtLink to="/admin/organizations" active-class="active">
          <Icon name="shield-check" />
          All Organizers
        </NuxtLink>
      </li>
    </ul>

  </aside>
</template>

<script setup>
import { onMounted, ref } from 'vue'
import defaultImage from '~/assets/image/image.png'
const imageUrl = computed(() => {
  return profile.value.image ? profile.value.image : defaultImage
})

const profile = ref({
  name: '',
  email: '',
  image: ''
})

onMounted(async () => {
try {
  const adminToken = localStorage.getItem('admin_token');

  if (!adminToken) {
    console.warn("No admin token found in localStorage. User not authenticated.");
    return;
  }

  const res = await $fetch('/api/admin/profile', {
    method: 'GET',
    headers: {
      'Authorization': `Bearer ${adminToken}`,
      'Accept': 'application/json'
    },
  })

  if (res && res.admin_information) {
    profile.value.name = res.admin_information.username || 'Admin';
    profile.value.email = res.admin_information.email || 'No Email';
    profile.value.image = res.admin_information.profile_image || '';
  } else {
    console.warn("Admin information not found in response.");
  }
} catch (error) {
  console.error('Failed to fetch profile:', error);
  // You might check error.response.status for 401 and redirect
  if (error.response && error.response.status === 401) {
      // Clear token and redirect to login if unauthorized
      localStorage.removeItem('admin_token');
      localStorage.removeItem('admin_email');
  }
}
})
</script>

<style scoped>
.active {
  background-color: #99C6FF;
  font-weight: bold;
}
</style>
