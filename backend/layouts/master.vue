<template>
  <div class="flex h-screen bg-white text-black overflow-hidden">
    
    <transition name="slide">
      <Sidebar v-if="sidebarOpen" />
    </transition>

    <div class="flex-1 flex flex-col min-w-0">
      
      <Navbar @toggle-sidebar="sidebarOpen = !sidebarOpen" />

      <main class="flex-1 overflow-y-auto p-4">
        <slot />
      </main>
      
    </div>
  </div>
</template>

<script setup>
import Navbar from '~/layouts/navbar.vue'
import Sidebar from '~/layouts/sidebar.vue'
import { ref } from 'vue'

const sidebarOpen = ref(true)
</script>

<style scoped>

.slide-enter-active,
.slide-leave-active {
  transition: transform 0.3s ease, width 0.3s ease;
}

.slide-enter-from,
.slide-leave-to {
  transform: translateX(-100%);
}
</style>