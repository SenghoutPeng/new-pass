<template>
  <section class="py-8">
    <div class="container mx-auto">
      <h2 class="text-xl font-bold text-gray-800 mb-6">{{ title }}</h2>
      <div class="relative w-full overflow-hidden">
        <div
          class="flex transition-transform duration-500 ease-in-out"
          :style="{ transform: `translateX(-${currentSlide * cardWidthWithMargin}px)` }"
        >
          <NuxtLink
            v-for="event in events"
            :key="event.event_id"
            :to="`/events/${event.event_id}`"
            class="flex-shrink-0 w-[492px] h-[296px] bg-white rounded-lg shadow-lg overflow-hidden transform hover:-translate-y-2 transition-transform duration-300 cursor-pointer mx-2"
          >
            <img :src="event.banner ? `${config.public.baseUrl}/storage/${event.banner}` : 'https://images.unsplash.com/photo-1522158637959-30385a09e0da?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'" :alt="event.title" class="w-full h-[160px] object-cover">
            <div class="p-4">
              <h3 class="font-bold text-lg mb-1">{{ event.title }}</h3>
              <p class="text-gray-600 text-sm mb-2">{{ formatDate(event.dates) }}</p>
              <div class="flex justify-between items-center">
                <span class="text-md font-bold text-blue-500">{{ formatPrice(event.dates) }}</span>
                <span class="text-blue-500 hover:text-blue-700">&rarr;</span>
              </div>
            </div>
          </NuxtLink>
          <p v-if="pending">Loading events...</p>
          <p v-else-if="error">Error loading events: {{ error.message }}</p>
          <p v-else-if="events.length === 0">No events found.</p>
        </div>

        <button
          @click="prevSlide"
          class="absolute left-0 top-1/2 -translate-y-1/2 bg-white p-2 rounded-full shadow-md hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-blue-400"
          v-if="events.length > 0"
        >
          <svg class="w-6 h-6 text-gray-700" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"></path>
          </svg>
        </button>
        <button
          @click="nextSlide"
          class="absolute right-0 top-1/2 -translate-y-1/2 bg-white p-2 rounded-full shadow-md hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-blue-400"
          v-if="events.length > 0"
        >
          <svg class="w-6 h-6 text-gray-700" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
          </svg>
        </button>
      </div>
    </div>
  </section>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted } from 'vue';
import { useLazyFetch } from '#app';

const props = defineProps({
  title: { type: String, required: true },
  apiUrl: { type: String, required: true },
  filterParams: { type: Object, default: () => ({}) }
});
const config = useRuntimeConfig()

const currentSlide = ref(0);
const cardWidth = 492;
const cardMargin = 16;
const cardWidthWithMargin = cardWidth + (cardMargin * 2); // 492 + 32 = 524

const maxVisibleItems = ref(0);
const calculateMaxVisibleItems = () => {
  maxVisibleItems.value = Math.floor(window.innerWidth / cardWidthWithMargin);
};
onMounted(() => {
  calculateMaxVisibleItems();
  window.addEventListener('resize', calculateMaxVisibleItems);
});
onUnmounted(() => {
  window.removeEventListener('resize', calculateMaxVisibleItems);
});

const { data: apiResponse, pending, error } = useLazyFetch(props.apiUrl, {
  baseURL: config.public.baseUrl,
  server: false,
  lazy: true,
  params: computed(() => props.filterParams),
  transform: (data) => data.events || [],
});

const events = computed(() => apiResponse.value || []);

const nextSlide = () => {
  const totalItems = events.value.length;
  const maxSlides = Math.max(0, totalItems - maxVisibleItems.value);
  if (currentSlide.value < maxSlides) {
    currentSlide.value++;
  } else {
    currentSlide.value = 0; // loop back
  }
};
const prevSlide = () => {
  const totalItems = events.value.length;
  const maxSlides = Math.max(0, totalItems - maxVisibleItems.value);
  if (currentSlide.value > 0) {
    currentSlide.value--;
  } else {
    currentSlide.value = maxSlides; // loop back
  }
};

const formatDate = (dates) => {
  if (!dates || dates.length === 0) return 'No date';
  const date = new Date(dates[0].event_date);
  return date.toLocaleDateString('en-US', { month: 'short', day: 'numeric' });
};

const formatPrice = (dates) => {
  if (!dates || dates.length === 0) return 'N/A';
  const prices = dates.map(d => d.ticket_price).filter(price => price !== undefined && price !== null);
  if (prices.length === 0) return 'N/A';
  const minPrice = Math.min(...prices);
  return minPrice === 0 ? 'Free' : `$${minPrice.toFixed(0)}`;
};
</script>

<style scoped>
.transition-transform {
  transition: transform 0.5s ease-in-out;
}
</style>
