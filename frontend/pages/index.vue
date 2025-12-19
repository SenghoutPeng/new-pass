<template>
  <div class="bg-white flex flex-col flex-grow">
    <main class="flex-grow">
      <section class="relative h-[500px] text-white flex flex-col items-center justify-center bg-teal-500">
        <div class="absolute inset-0 bg-cover bg-center opacity-20"
          style="background-image: url('https://placehold.co/1920x600/000000/FFFFFF?text=World+Map');"></div>
        <div class="relative z-10 text-center">
          <h1 class="text-7xl md:text-9xl font-extrabold tracking-tighter her
          o-text">Tickets</h1>
          <p class="text-7xl md:text-9xl font-extrabold tracking-tighter -mt-8 hero-text">SALE</p>
        </div>
      </section>
      <div class="items-center flex flex-col">
      <div class="flex justify-center z-10 mt-6 w-full px-4 pb-10 mb-10">
        <div class="relative w-full max-w-2xl">
          <input
            v-model="searchQuery"
            type="text"
            placeholder="Search for events, artists, or venues"
            class="w-full h-14 pl-12 pr-4 rounded-full text-gray-700 focus:outline-none focus:ring-2 focus:ring-blue-400 shadow-lg"
            @keyup.enter="handleSearch"
          >
          <svg class="w-6 h-6 text-gray-400 absolute left-4 top-1/2 -translate-y-1/2" fill="none" stroke="currentColor"
            viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
          </svg>
        </div>
      </div>

      <section class="py-12 bg-gray-50 -mt-16">
        <div class="container mx-auto px-6">
          <EventCarousel title="Featured Events" apiUrl="/api/on-going-events" :filterParams="{ limit: 10, sort: 'featured' }" />
          <EventCarousel title="Popular Events" apiUrl="/api/popular-events" :filterParams="{ limit: 5, sort: 'popular' }" />
        </div>
      </section>

      <section class="py-12 bg-white">
        <div class="container mx-auto px-6 text-center">
          <h2 class="text-3xl font-bold text-gray-800 mb-8">How to Buy the Ticket</h2>
          <div class="flex flex-wrap justify-center items-center gap-8 md:gap-16">
            <div v-for="step in steps" :key="step.number" class="flex flex-col items-center">
              <div
                class="w-16 h-16 bg-blue-100 rounded-full flex items-center justify-center text-blue-500 font-bold text-2xl">
                {{ step.number }}
              </div>
              <p class="mt-2 text-gray-600">{{ step.title }}</p>
            </div>
          </div>
        </div>
      </section>

      <section v-if="!isAuthenticated" class="py-12 bg-gray-50" >
        <div class="container mx-auto px-6">
          <h2 class="text-3xl font-bold text-center text-gray-800 mb-8">Solutions For Everyone</h2>
          <div class="flex justify-center gap-8">
            <div class="bg-white p-8 rounded-lg shadow-lg w-full max-w-md">
              <h3 class="text-2xl font-bold text-center mb-4">For Attendees</h3>
              <ul class="space-y-3 text-gray-600">
                <li class="flex items-start">
                  <span class="text-green-500 mr-2">&#10003;</span>
                  Discover and attend events that matter.
                </li>
                <li class="flex items-start">
                  <span class="text-green-500 mr-2">&#10003;</span>
                  Quick and secure ticket purchases.
                </li>
                <li class="flex items-start">
                  <span class="text-green-500 mr-2">&#10003;</span>
                  Digital tickets accessible on any device.
                </li>
              </ul>
              <div class="text-center mt-6">
                <button
                  @click="navigateToEvents"
                  class="bg-blue-500 text-white px-6 py-2 rounded-lg hover:bg-blue-600"
                >
                  Find Events
                </button>
              </div>
            </div>
            <div class="bg-white p-8 rounded-lg shadow-lg w-full max-w-md">
              <h3 class="text-2xl font-bold text-center mb-4">For Event Organizers</h3>
              <ul class="space-y-3 text-gray-600">
                <li class="flex items-start">
                  <span class="text-green-500 mr-2">&#10003;</span>
                  Create, promote, and manage your events.
                </li>
                <li class="flex items-start">
                  <span class="text-green-500 mr-2">&#10003;</span>
                  Comprehensive sales analytics.
                </li>
                <li class="flex items-start">
                  <span class="text-green-500 mr-2">&#10003;</span>
                  Streamlined check-in and attendance tracking.
                </li>
              </ul>
              <div class="text-center mt-6">
                <button
                  @click="navigateToCreateEvent"
                  class="border border-blue-500 text-blue-500 px-6 py-2 rounded-lg hover:bg-blue-50"
                >
                  Create Event
                </button>
              </div>
            </div>
          </div>
        </div>
      </section>
    </div>
    </main>
  </div>
</template>

<script setup>
import { ref, reactive, computed} from 'vue';
import { useHead, useLazyFetch, navigateTo } from '#app';
const config = useRuntimeConfig()
// Specify the layout for this page
definePageMeta({
  layout: 'master',
});

// Meta tags for SEO
useHead({
  title: 'MyTickets - Find and Book Amazing Events',
  meta: [
    { name: 'description', content: 'Discover and book tickets for amazing events. From music festivals to tech conferences, find your next experience.' }
  ]
})
const { data: user } = await useFetch(`${config.public.baseUrl}/api/profile`, { credentials: 'include' })

const isAuthenticated = computed(() => !!user.value)
// Reactive data
const searchQuery = ref('');
const selectedCategories = ref([]); // Placeholder for category filtering (if you implement category filtering in the search bar later)

const { data: searchResults, pending: searchPending, error: searchError, refresh: refreshSearch } = useLazyFetch('/api/events', {
  baseURL: '',
  server: false,
  lazy: true,
  params: {
    keyword: searchQuery,
  },
  transform: (data) => data.events,
});

// Mock data for "How to Buy the Ticket" section
const steps = ref([
  { number: 1, title: 'Search Events' },
  { number: 2, title: 'Select Tickets' },
  { number: 3, title: 'Enter Details' },
  { number: 4, title: 'Make Payment' },
  { number: 5, title: 'Get Tickets' }
])

// Rating modal state and logic
const showRating = ref(false);
const ratings = reactive({});

const setRating = (key, value) => {
  ratings[key] = value;
};

const submitRating = () => {
  console.log('Submitted Ratings:', ratings);
  alert('Thank you for your feedback! Your ratings have been submitted.');
  showRating.value = false;
};


const handleSearch = () => {
  navigateTo({ path: '/events', query: { keyword: searchQuery.value } });
};

const navigateToEvents = () => {
  navigateTo('/signup')
}

const navigateToCreateEvent = () => {
  navigateTo('/organization/signup')
}

</script>
<style scoped>


.hero-text {
  font-family: 'Brush Script MT', cursive;
  text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.5);
}

.transition-transform {
  transition: transform 0.3s ease;
}
</style>
