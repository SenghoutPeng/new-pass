<template>
  <div class="flex flex-col min-h-screen">
    <Navbar />

    <div class="flex flex-1 overflow-hidden">
    <div v-if="userType == 'organization' && isOrganization" >
      <Sidebar class="w-64 shrink-0" />
    </div>
      
    <main class="flex-grow overflow-auto">
      <slot />
    </main>
    </div>
    <div v-if="userType == 'user' || userType == null">
      <Footer />
    </div>
      </div>
</template>

<script setup>
import Footer from '~/layouts/footer.vue'
import Navbar from '~/layouts/navbar.vue'
import Sidebar from './sidebar.vue'
const user = useSanctumUser()

//  Check if user.value exists before accessing its properties
const userType = computed(() => {
  if (user.value) {
    return user.value.type;
  }
  return null;
});



const route = useRoute()
const isOrganization = computed(() => route.path.startsWith('/organization'));
</script>