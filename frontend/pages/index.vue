<template>
  <div class="bg-white flex flex-col flex-grow">
    <main class="flex-grow">
      <!-- HERO -->
      <section class="relative h-[500px] text-white flex flex-col items-center justify-center bg-teal-500">
        <div
          class="absolute inset-0 bg-cover bg-center opacity-20"
          style="background-image: url('https://placehold.co/1920x600/000000/FFFFFF?text=World+Map');"
        ></div>

        <div class="relative z-10 text-center">
          <h1 class="text-7xl md:text-9xl font-extrabold tracking-tighter hero-text">
            Tickets
          </h1>
          <p class="text-7xl md:text-9xl font-extrabold tracking-tighter -mt-8 hero-text">
            SALE
          </p>
        </div>
      </section>

      <!-- SEARCH BAR -->
      <div class="flex justify-center z-10 mt-6 w-full px-4 pb-10 mb-10">
        <div class="relative w-full max-w-2xl">
          <input
            v-model="searchQuery"
            type="text"
            placeholder="Search for events, artists, or venues"
            class="w-full h-14 pl-12 pr-4 rounded-full text-gray-700 focus:outline-none focus:ring-2 focus:ring-blue-400 shadow-lg"
            @keyup.enter="handleSearch"
          />
          <svg
            class="w-6 h-6 text-gray-400 absolute left-4 top-1/2 -translate-y-1/2"
            fill="none"
            stroke="currentColor"
            viewBox="0 0 24 24"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
            />
          </svg>
        </div>
      </div>

      <!-- SEARCH RESULTS -->
      <section v-if="searched" class="py-12 bg-gray-50">
        <div class="container mx-auto px-6">
          <EventCarousel
            title="Search Results"
            apiUrl="/api/events"
            :filterParams="{ keyword: searchQuery }"
          />
        </div>
      </section>


      <!-- EVENT CAROUSELS (HOME VIEW) -->
      <section v-else class="py-12 bg-gray-50 -mt-16">
        <div class="container mx-auto px-6">
          <EventCarousel
            title="Featured Events"
            apiUrl="/api/on-going-events"
            :filterParams="{ limit: 10, sort: 'featured' }"
          />

          <EventCarousel
            title="Popular Events"
            apiUrl="/api/popular-events"
            :filterParams="{ limit: 5, sort: 'popular' }"
          />
        </div>
      </section>

      <!-- HOW TO BUY -->
      <section class="py-12 bg-white">
        <div class="container mx-auto px-6 text-center">
          <h2 class="text-3xl font-bold text-gray-800 mb-8">
            How to Buy the Ticket
          </h2>

          <div class="flex flex-wrap justify-center gap-8">
            <div v-for="step in steps" :key="step.number" class="flex flex-col items-center">
              <div
                class="w-16 h-16 bg-blue-100 rounded-full flex items-center justify-center text-blue-500 font-bold text-2xl"
              >
                {{ step.number }}
              </div>
              <p class="mt-2 text-gray-600">{{ step.title }}</p>
            </div>
          </div>
        </div>
      </section>
    </main>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import { useHead, useFetch } from '#app'

definePageMeta({
  layout: 'master'
})

useHead({
  title: 'MyTickets - Find and Book Amazing Events',
  meta: [
    {
      name: 'description',
      content: 'Discover and book tickets for amazing events.'
    }
  ]
})

const config = useRuntimeConfig()

const searchQuery = ref('')
const searched = ref(false)

const handleSearch = () => {
  if (!searchQuery.value.trim()) return
  searched.value = true
  refresh()
}

const steps = ref([
  { number: 1, title: 'Search Events' },
  { number: 2, title: 'Select Tickets' },
  { number: 3, title: 'Enter Details' },
  { number: 4, title: 'Make Payment' },
  { number: 5, title: 'Get Tickets' }
])
</script>

<style scoped>
.hero-text {
  font-family: 'Brush Script MT', cursive;
  text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.5);
}
</style>
