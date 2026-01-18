<template>
  <div class="min-h-screen bg-gray-50 flex flex-col">
    <div v-if="pending" class="flex-1 flex items-center justify-center">
      <p class="text-gray-600">Loading event details...</p>
    </div>

    <div v-else-if="error" class="flex-1 flex items-center justify-center">
      <p class="text-red-500">Error loading event: {{ error.message }}</p>
      <p v-if="error.statusCode === 404">Event not found.</p>
    </div>

    <template v-else-if="eventData">
      <div class="relative w-full h-100">
        <img
          :src="eventData.banner ? `${config.public.baseUrl}/storage/${eventData.banner}` : 'https://images.unsplash.com/photo-1522158637959-30385a09e0da?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'"
          alt="Event Banner"
          class="absolute inset-0 w-full h-full object-cover"
        />
      </div>

      <main class="max-w-7xl mx-auto p-4 flex-1">
        <h1 class="text-xl font-bold my-4">{{ eventData.title }}</h1>
        <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
          <div>
            <h2 class="font-semibold text-sm mb-1">Event Description</h2>
            <p class="text-xs text-gray-600">{{ eventData.description }}</p>
          </div>
          <div>
            <h2 class="font-semibold text-sm mb-1">Location</h2>
            <div class="flex items-center">
              <img src="/assets/css/image/location.png" alt="Location" width="20" height="20"/>
              <p class="text-xs text-gray-600">{{ eventData.location }}</p>
            </div>
          </div>
        </div>

        <h2 class="font-semibold text-sm mb-2" v-if="userType != 'organization'">Select Ticket</h2>
        <h2 class="font-semibold text-sm mb-2" v-if="userType === 'organization'">Ticket Information</h2>
        <div class="grid grid-cols-1 sm:grid-cols-2 gap-3 mb-4">

          <div v-for="(date, index) in eventData.dates" :key="index"
            class="flex items-center justify-between border rounded p-2 bg-white">
            <div class="text-xs">
              <div class="font-medium">{{ formatDate(date.event_date) }} at {{ date.event_time }}</div>
              <div class="text-blue-600">{{ formatPrice(date.ticket_price) }}</div>
              <div class="text-gray-500 text-[10px]" v-if="date.total_ticket !== null && date.total_ticket > 0">Tickets Left: {{ date.total_ticket }}</div>
              <div class="text-red-500 text-[10px]" v-else-if="date.total_ticket === 0">Sold Out</div>
              <div class="text-gray-500 text-[10px]" v-else>Tickets Left: N/A</div>
            </div>
            <select  v-if="userType === 'user' || userType === null" v-model="date.selectedQuantity"
              class="border rounded text-xs px-1 py-0.5"
              :disabled="date.total_ticket === 0 || date.total_ticket === null">
              <option :value="0">0</option>
              <option v-for="n in Math.min(date.total_ticket, 3)" 
          :key="n"
          :value="n">
    {{ n }}
  </option>
            </select>
          </div>
          </div>
        <button class="bg-blue-500 hover:bg-blue-600 text-white text-xs font-medium px-4 py-1.5 rounded"
          @click="checkout" v-if="userType === 'user' || userType === null">Check Out</button>

        <section class="py-12 bg-gray-50 -mt-16">
        <div class="container mx-auto px-6">
          <EventCarousel title="Other Events" apiUrl="/api/on-going-events" :filterParams="{ limit: 10, sort: 'featured' }" />
        </div>
      </section>
      </main>
      </template>
  </div>
</template>

<script setup>
import { computed } from 'vue';
import { useRoute, useRouter } from 'vue-router';

definePageMeta({
  layout: 'master', 

});

const route = useRoute();
const router = useRouter();
const eventId = computed(() => route.params.id);
const config = useRuntimeConfig()
const user = useSanctumUser();
const userType = computed(() => {
  if (user.value) {
    return user.value.type;
  }
  return null;
});

const isLoggedIn = () => {
  return typeof localStorage !== 'undefined' && !!localStorage.getItem('user_token');
};

const { data: eventData, pending, error } = useLazyFetch(() => `${config.public.apiUrl}/events/${eventId.value}`, {
  transform: (response) => {
    if (response && response.event_detail) {
      console.log('Transformed Event Data:', response.event_detail);
      response.event_detail.dates = response.event_detail.dates.map(date => ({
        ...date,
        selectedQuantity: 0
      }));
      return response.event_detail;
    }
    return null;
  },
  server: false,
});


const formatDate = (dateString) => {
  if (!dateString) return '';
  const date = new Date(dateString);
  if (isNaN(date.getTime())) {
    console.warn('Invalid date string:', dateString);
    return dateString;
  }
  return date.toLocaleDateString('en-US', { day: 'numeric', month: 'long', year: 'numeric' });
};

const formatPrice = (price) => {
  const numericPrice = parseFloat(price);
  if (isNaN(numericPrice)) return 'N/A';
  if (numericPrice === 0) return 'Free';
  return `$${numericPrice.toFixed(2)}`;
};

const selected = useState('selectedEvent', () => null);

const checkout = () => {
  if (!eventData.value) {
    alert('Event data not loaded yet. Please try again.');
    return;
  }

  const selectedTickets = eventData.value.dates.filter(date => date.selectedQuantity > 0);

  if (selectedTickets.length === 0) {
    alert('Please select at least one ticket quantity.');
    return;
  }

  if (!isLoggedIn()) {
    alert('Please log in to proceed with checkout.');
    router.push('/login');
    return;
  }

  let totalPrice = 0;
  selectedTickets.forEach(ticket => {
    totalPrice += ticket.ticket_price * ticket.selectedQuantity;
  });

  selected.value = {
    eventId: eventData.value.event_id,
    title: eventData.value.title,
    description: eventData.value.description,
    banner: eventData.value.banner,
    totalPrice: totalPrice,
    selectedTickets: selectedTickets.map(ticket => ({
      event_date_id: ticket.event_date_id,
      event_date: ticket.event_date,
      event_time: ticket.event_time,
      ticket_price: ticket.ticket_price,
      quantity: ticket.selectedQuantity,
      formattedDate: formatDate(ticket.event_date) + ' at ' + ticket.event_time.substring(0, 5),
    })),
  };

  console.log('Navigating to payment with:', selected.value);
  router.push('/payment');
};
</script>