<template>
  <div class="min-h-screen bg-gray-50">


    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 mt-6">
      <div class="relative">
        <input v-model="searchQuery" @input="debouncedFetchEvents" type="text"
          placeholder="Search for events, venues, or artists"
          class="w-full pl-4 pr-10 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent" />
        <button class="absolute inset-y-0 right-0 pr-3 flex items-center">
          <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
              d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
          </svg>
        </button>
      </div>
    </div>

    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
      <div class="flex gap-8">
        <aside class="w-64 flex-shrink-0">
          <div class="bg-white rounded-lg border border-gray-300 p-6">
            <h2 class="text-lg font-semibold text-gray-900 mb-4">Filters</h2>

    <div class="mb-6">
      <h3 class="text-sm font-medium text-gray-700 mb-3">Category</h3>
      <div class="space-y-2">
  <label
  v-for="category in categories"
  :key="category.id"
  class="flex items-center space-x-2"
>
  <input
    type="checkbox"
    v-model="selectedCategory"
    :value="category.id"
    @change="fetchEvents"
    class="h-4 w-4 text-blue-600 border border-gray-300 rounded"
  />

  <span class="text-sm text-gray-600 flex items-center">
    <component
      :is="category.icon"
      class="w-4 h-4 mr-2"
      :class="category.color"
    />
    {{ category.name }}
  </span>
</label>


      </div>
    </div>

          <div>
            <h3 class="text-sm font-medium text-gray-700 mb-3">Date</h3>
            <div class="space-y-2">
              <label v-for="dateOption in dateOptions" :key="dateOption.value" class="flex items-center">
                <input v-model="selectedDate" :value="dateOption.value" type="radio" name="date"
                  class="h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300" @change="fetchEvents" />
                <span class="ml-3 text-sm text-gray-600">{{ dateOption.label }}</span>
              </label>
            </div>
          </div>
        </div>
      </aside>

      <main class="flex-1">
        <div class="mb-3">
          <h1 class="text-2xl font-bold text-gray-900">EVENTS</h1>
        </div>

        <div class="space-y-6">
          <div v-for="event in paginatedEvents" :key="event.event_id"
            class="bg-white rounded-lg  border border-gray-300 overflow-hidden  hover:shadow transition-shadow cursor-pointer"
            @click="viewEvent(event)">
            <div class="flex">
              <div class="w-80 h-48 flex-shrink-0">
                <img :src="`${config.public.baseUrl}/storage/${event.banner}` || `${config.public.baseUrl}/storage/banner/deafult.png`" :alt="event.title" class="w-full h-full object-cover" />
              </div>

              <div class="flex-1 p-6">
                <div class="flex justify-between items-start">
                  <div class="flex-1">
                    <h3 class="text-xl font-semibold text-gray-900 mb-2">{{ event.title }}</h3>
                    <p class="text-gray-600 mb-3 leading-relaxed">{{ event.description }}</p>
                    <p class="text-gray-500 text-sm mb-4">
                      {{ getDisplayDate(event.dates) }}
                      <span v-if="getDisplayPrice(event.dates) !== 'Free'"> - {{ getDisplayPrice(event.dates) }}</span>
                    </p>

                    <div class="flex items-center">
                      <span v-if="getDisplayPrice(event.dates) === 'Free'"
                        class="text-green-600 font-semibold">Free</span>
                      <span v-else class="text-blue-600 font-semibold">{{ getDisplayPrice(event.dates) }}</span>
                    </div>
                  </div>

                  <div class="ml-4">
                    <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-medium"
                      :class="getCategoryBadgeClass(event.event_category_name)">
                      {{ event.event_category_name }}
                    </span>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="flex justify-center items-center space-x-2 mt-8">
          <button class="px-3 py-2 text-gray-500 hover:text-gray-700" :disabled="currentPage === 1"
            @click="currentPage--">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
            </svg>
          </button>

          <button v-for="page in totalPages" :key="page" @click="currentPage = page"
            class="px-3 py-2 text-sm font-medium rounded-lg transition-colors"
            :class="page === currentPage ? 'bg-blue-500 text-white' : 'text-gray-700 hover:bg-gray-100'">
            {{ page }}
          </button>

          <button class="px-3 py-2 text-gray-500 hover:text-gray-700" :disabled="currentPage === totalPages"
            @click="currentPage++">
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
            </svg>
          </button>
        </div>
      </main>
    </div>
  </div>
</div>
</template>


<script setup>
import {
  ref,
  computed,
} from 'vue'

// Page meta
definePageMeta({
  layout: 'master',

})
const config = useRuntimeConfig()
// Reactive data
const searchQuery = ref('')
const selectedCategory = ref([])
const selectedDate = ref('all')
const currentPage = ref(1)
const itemsPerPage = 10; 

const MusicIcon = {
  template: '<svg class="w-4 h-4" fill="currentColor" viewBox="0 0 24 24"><path d="M12 3v10.55c-.59-.34-1.27-.55-2-.55-2.21 0-4 1.79-4 4s1.79 4 4 4 4-1.79 4-4V7h4V3h-6zm-2 16c-1.1 0-2-.9-2-2s.9-2 2-2 2 .9 2 2-.9 2-2 2z"/></svg>'
};
const StarIcon = {
  template: '<svg class="w-4 h-4" fill="currentColor" viewBox="0 0 24 24"><path d="M12 17.27L18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z"/></svg>'
};
const PresentationIcon = {
  template: '<svg class="w-4 h-4" fill="currentColor" viewBox="0 0 24 24"><path d="M12 8c1.1 0 2-.9 2-2s-.9-2-2-2-2 .9-2 2 .9 2 2 2zm0 2c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2zm0 4c-1.1 0-2 .9-2 2s.9 2 2 2 2-.9 2-2-.9-2-2-2zm-6 2H4V8c0-1.1.9-2 2-2h2c1.1 0 2 .9 2 2v8h-4zM20 8h-2c-1.1 0-2 .9-2 2v8h4V8zm-6 0c0-1.1.9-2 2-2h2V4H8v2h2c1.1 0 2 .9 2 2z"/></svg>'
};
const TrophyIcon = {
  template: '<svg class="w-4 h-4" fill="currentColor" viewBox="0 0 24 24"><path d="M18 9.5l-6 4.5-6-4.5V3h12v6.5zm-6-2.91L14.09 7l1.01-2.19L18 3H6L4.9 4.81 6.91 7 8 7.09V9.5h8V7.09zM4 11v8c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2v-8H4z"/></svg>'
};


const categories = ref([
  {
    id: 'Concerts',
    name: 'Concerts',
    icon: MusicIcon,
    color: 'text-purple-500'
  },
  {
    id: 'Festivals',
    name: 'Festivals',
    icon: StarIcon,
    color: 'text-yellow-500'
  },
  {
    id: 'Conferences',
    name: 'Conferences',
    icon: PresentationIcon,
    color: 'text-blue-500'
  },
  {
    id: 'Sports',
    name: 'Sports',
    icon: TrophyIcon,
    color: 'text-green-500'
  }
])

const dateOptions = ref([
  {
    value: 'all',
    label: 'All Dates'
  },
  {
    value: 'today',
    label: 'Today'
  },
  {
    value: 'tomorrow',
    label: 'Tomorrow'
  },
  {
    value: 'this-week',
    label: 'This Week'
  },
])

// Debounce function
const debounce = (func, delay) => {
  let timeout;
  return function(...args) {
    const context = this;
    clearTimeout(timeout);
    timeout = setTimeout(() => func.apply(context, args), delay);
  };
};


// Fetch events function
const {
  data: apiResponse,
  refresh: fetchEvents
} = useLazyFetch(`${config.public.apiUrl}/on-going-events`, {
  server: false,
  lazy: true,
  watch: [searchQuery], 
  transform: (data) => data.events,
  params: {
    keyword: searchQuery,
  },
})

const debouncedFetchEvents = debounce(fetchEvents, 300); 


// Computed properties
const events = computed(() => apiResponse.value || []) 
const filteredEvents = computed(() => {
  let filtered = events.value;

  if (selectedCategory.value.length > 0) {
    filtered = filtered.filter(event => 
      selectedCategory.value.includes(event.event_category_name)
    );
  }

  // Filter by selected date
  if (selectedDate.value !== 'all') {
    const today = new Date().toDateString();
    const tomorrow = new Date(Date.now() + 86400000).toDateString();

    filtered = filtered.filter(event => {
      if (!event.dates || event.dates.length === 0) return false;

      const eventDates = event.dates.map(d => new Date(d.event_date).toDateString());

      if (selectedDate.value === 'today') {
        return eventDates.includes(today);
      }
      if (selectedDate.value === 'tomorrow') {
        return eventDates.includes(tomorrow);
      }
      if (selectedDate.value === 'this-week') {
        const now = new Date();
        const weekFromNow = new Date();
        weekFromNow.setDate(now.getDate() + 7);
        return eventDates.some(ed => {
          const date = new Date(ed);
          return date >= now && date <= weekFromNow;
        });
      }
      return true;
    });
  }

  return filtered;
})

const paginatedEvents = computed(() => {
  const startIndex = (currentPage.value - 1) * itemsPerPage;
  const endIndex = startIndex + itemsPerPage;
  return filteredEvents.value.slice(startIndex, endIndex);
});

const totalPages = computed(() => Math.ceil(filteredEvents.value.length / itemsPerPage))

// Methods
const getCategoryBadgeClass = (categoryName) => {
  const classes = {
    'Concerts': 'bg-purple-100 text-purple-800',
    'Festivals': 'bg-yellow-100 text-yellow-800',
    'Conferences': 'bg-blue-100 text-blue-800',
    'Sports': 'bg-green-100 text-green-800'
  }
  return classes[categoryName] || 'bg-gray-100 text-gray-800'
}

const getDisplayDate = (dates) => {
  if (!dates || dates.length === 0) return 'No date available';
  // If there's only one date, display it directly
  if (dates.length === 1) {
    return new Date(dates[0].event_date).toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    });
  }
  // If multiple dates, find the min and max dates
  const sortedDates = dates.map(d => new Date(d.event_date)).sort((a, b) => a - b);
  const firstDate = sortedDates[0];
  const lastDate = sortedDates[sortedDates.length - 1];

  const firstDateFormatted = firstDate.toLocaleDateString('en-US', {
    month: 'long',
    day: 'numeric'
  });
  const lastDateFormatted = lastDate.toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  });

  if (firstDate.getFullYear() === lastDate.getFullYear()) {
    return `${firstDateFormatted} - ${lastDateFormatted}`;
  } else {
    return `${firstDate.toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' })} - ${lastDateFormatted}`;
  }
};

const getDisplayPrice = (dates) => {
  if (!dates || dates.length === 0) return 'Price not available';

  const prices = dates.map(d => d.ticket_price).filter(price => price !== undefined && price !== null);

  if (prices.length === 0) return 'Price not available';

  const minPrice = Math.min(...prices);
  const maxPrice = Math.max(...prices);

  if (minPrice === 0 && maxPrice === 0) {
    return 'Free';
  } else if (minPrice === maxPrice) {
    return `$${minPrice.toFixed(2)}`;
  } else {
    return `$${minPrice.toFixed(2)}-${maxPrice.toFixed(2)}`;
  }
};

const viewEvent = (event) => {
  navigateTo(`/events/${event.event_id}`);
}

</script>