<template>
  <div class="min-h-screen bg-white flex-col flex justify-center">

    <main class="max-w-md mx-auto p-4">
      <div class="bg-white rounded shadow p-4 w-100">
        <h1 class="font-bold text-xl mb-4 text-center">Order Summary</h1>

        <template v-if="selected && selected.eventId">
          <img :src="selected.banner ? `/storage/${selected.banner}` : 'https://via.placeholder.com/200?text=Event+Banner'"
            alt="Event Banner" class="w-full h-40 object-cover rounded mb-3">
          <p class="font-bold text-lg mb-1">{{ selected.title }}</p>
          <p class="text-sm text-gray-600 mb-3">{{ selected.description }}</p>

          <h2 class="font-semibold text-base mb-2">Selected Tickets:</h2>
          <div v-for="(ticket, index) in selected.selectedTickets" :key="index" class="border-b pb-2 mb-2 last:border-b-0 last:pb-0 last:mb-0">
            <p class="text-sm font-medium">{{ ticket.formattedDate }}</p>
            <p class="text-xs text-gray-700">Quantity: {{ ticket.quantity }}</p>
            <p class="text-xs text-blue-600">Price per ticket: {{ formatPrice(ticket.ticket_price) }}</p>
            <p class="text-xs text-green-600 font-medium">Subtotal: {{ formatPrice(ticket.ticket_price * ticket.quantity) }}</p>
          </div>

          <div class="flex justify-between items-center mt-4 pt-4 border-t-2 border-gray-200">
            <p class="font-bold text-lg">Total Price:</p>
            <p class="font-bold text-xl text-blue-700">{{ formatPrice(selected.totalPrice) }}</p>
          </div>

          <p v-if="paymentError" class="text-red-500 text-sm mt-3">{{ paymentError }}</p>
          <p v-if="paymentSuccessMessage" class="text-green-500 text-sm mt-3">{{ paymentSuccessMessage }}</p>

          <button @click="completePayment"
            :disabled="processingPayment"
            class="bg-blue-500 hover:bg-blue-600 text-white w-full rounded p-3 mt-4 text-lg font-semibold flex items-center justify-center">
            <span v-if="processingPayment" class="animate-spin mr-2 h-5 w-5 border-t-2 border-r-2 border-white rounded-full"></span>
            {{ processingPayment ? 'Processing...' : 'Complete Payment' }}
          </button>
        </template>
        <template v-else>
          <p class="text-center text-gray-500">No event selected. Please go back to the event page.</p>
          <NuxtLink to="/" class="block text-center text-blue-500 hover:underline mt-4">Go to Events</NuxtLink>
        </template>
      </div>
    </main>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router'; // Import useRouter
definePageMeta({
  layout: 'master',
  middleware: 'sanctum:auth'
});
const router = useRouter(); // Initialize router
const selected = useState('selectedEvent'); // Retrieve the shared state
const config = useRuntimeConfig()
const processingPayment = ref(false);
const paymentError = ref(null);
const paymentSuccessMessage = ref(null);
const client = useSanctumClient();
// Helper function to format price
const formatPrice = (price) => {
  if (price === 0) return 'Free';
  return `$${parseFloat(price).toFixed(2)}`;
};

const completePayment = async () => {
  processingPayment.value = true;
  paymentError.value = null;
  paymentSuccessMessage.value = null;

  if (!selected.value || !selected.value.selectedTickets || selected.value.selectedTickets.length === 0) {
    paymentError.value = "No tickets selected for payment.";
    processingPayment.value = false;
    return;
  }
  await $fetch(`${config.public.baseUrl}/sanctum/csrf-cookie`, {
  credentials: 'include'
});
  // Iterate over each selected ticket and make a separate API call
  for (const ticket of selected.value.selectedTickets) {
    try {
      const response = await client('/api/buy-ticket', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: {
          event_id: selected.value.eventId,
          event_date_id: ticket.event_date_id,
          quantity: ticket.quantity,
        },
      });

      // Handle success for each ticket (you might want more granular feedback)
      console.log('Ticket purchase successful:', response);
      // If one fails, you might want to stop or notify differently
      paymentSuccessMessage.value = 'Ticket(s) purchased successfully!';

    } catch (err) {
      console.error('Payment error:', err);
      // You should handle different error codes from backend (e.g., insufficient balance)
      paymentError.value = err.data?.error || err.data?.message || 'Payment failed. Please try again.';
      processingPayment.value = false;
      return; // Stop processing further tickets if one fails
    }
  }

  processingPayment.value = false;
  // Redirect after all successful payments
  if (!paymentError.value) {
    // Clear the selected state after successful payment if desired
    selected.value = null;
    alert('All selected tickets purchased successfully!');
    router.push('/profile'); // Redirect to a page showing user's tickets
  }
};
</script>
