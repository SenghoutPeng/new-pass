<template>
  <div class="min-h-screen bg-gray-50">
    <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-10">
      <h1 class="text-2xl font-bold mb-6">User Information</h1>
      <div class="grid grid-cols-1 sm:grid-cols-3 gap-4 mb-8">
        <div class="bg-white shadow rounded-lg p-4 text-center">
          <div class="text-gray-600 text-sm">Your Balance</div>
          <button @click="goToRecharge" class="text-xl font-bold text-blue-600 hover:underline">
            ${{ userProfile?.balance ? parseFloat(userProfile.balance).toFixed(2) : '0.00' }}
          </button>
        </div>
        <div class="bg-white shadow rounded-lg p-4 text-center">
          <div class="text-gray-600 text-sm">Completed Purchases</div>
          <div class="text-xl font-bold">{{ userProfile?.total_purchases || 0 }}</div>
        </div>
        <div class="bg-white shadow rounded-lg p-4 text-center">
          <div class="text-gray-600 text-sm">Total Spending</div>
          <div class="text-xl font-bold">${{ userProfile?.total_spending ? parseFloat(userProfile.total_spending).toFixed(2) : '0.00' }}</div>
        </div>
      </div>

      <div class="bg-white shadow rounded-lg p-6 mb-10">
        <form @submit.prevent="saveChanges">
          <div class="flex items-center space-x-4 mb-6">
            <label for="profileImageInput" class="cursor-pointer">
              <img :src="profileImagePreview"
                   alt="User Avatar" class="w-14 h-14 rounded-full object-cover">
              <input type="file" id="profileImageInput" class="hidden" @change="handleImageUpload" accept="image/*">
            </label>
            <div>
              <input type="text" v-model="form.username" class="font-bold text-lg border-gray-300 focus:outline-none focus:border-blue-500">
              <input type="email" v-model="form.email" class="text-gray-600  border-gray-300 focus:outline-none focus:border-blue-500 mt-1 block">
            </div>
          </div>
          <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
            <div>ID: <span class="text-gray-700">{{ userProfile?.user_id || 'N/A' }}</span></div>
            <div>Name:
              <input type="text" v-model="form.username" class="text-gray-700 border-b border-gray-300 focus:outline-none focus:border-blue-500">
            </div>
            <div>Email:
              <input type="email" v-model="form.email" class="text-gray-700 border-b border-gray-300 focus:outline-none focus:border-blue-500">
            </div>
            <div class="flex items-center">
              <span class="mr-2">Password:</span>
              <span class="text-gray-700">********</span>
              <button @click="goToChangePassword" type="button" class="ml-2 bg-blue-500 text-white text-sm px-2 py-1 rounded cursor-pointer">Change</button>
            </div>
          </div>
          <div v-if="saveError" class="text-red-500 text-sm mt-4">{{ saveError }}</div>
          <div v-if="saveSuccess" class="text-green-500 text-sm mt-4">{{ saveSuccess }}</div>
          <div class="mt-6 flex space-x-4">
            <button type="submit" :disabled="savingChanges" class="w-full bg-blue-500 text-white py-2 rounded hover:bg-blue-600 disabled:opacity-50">
              {{ savingChanges ? 'Saving...' : 'Save Changes' }}
            </button>
            <button @click="goToRecharge" type="button" class="w-full bg-green-500 text-white py-2 rounded hover:bg-green-600">Recharge Balance</button>
          </div>
        </form>
      </div>

      <div>
        <h2 class="text-xl font-semibold mb-4">Tickets</h2>
        <div v-if="pendingTickets || pendingProfile" class="text-center text-gray-600">Loading user data and tickets...</div>
        <div v-else-if="errorTickets || errorProfile" class="text-center text-red-500">
          Error loading data: {{ errorTickets?.message || errorProfile?.message || 'Unknown error' }}. Make sure you are logged in.
        </div>
        <div v-else-if="userTickets && userTickets.length > 0" class="bg-white shadow rounded-lg overflow-x-auto">
          <table class="min-w-full text-sm text-left">
            <thead class="bg-gray-100">
              <tr>
                <th class="px-4 py-2">TITLE</th>
                <th class="px-4 py-2">STATUS</th>
                <th class="px-4 py-2">PURCHASE DATE</th>
                <th class="px-4 py-2">QUANTITY</th>
                <th class="px-4 py-2">TOTAL PRICE</th>
                <th class="px-4 py-2">RATING</th>
                <th class="px-4 py-2">CHECK-IN CODES</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="ticket in userTickets" :key="ticket.event_id" class="border-t">
                <td class="px-4 py-2">{{ ticket.title }}</td>
                <td class="px-4 py-2">
                  <span :class="getStatusClass('bought')" class="px-2 py-1 rounded text-xs font-medium">COMPLETED</span>
                </td>
                <td class="px-4 py-2">{{ formatDate(ticket.last_purchase_date) }}</td>
                <td class="px-4 py-2">{{ ticket.total_tickets_purchased }}</td>
                <td class="px-4 py-2">${{ parseFloat(ticket.total_price_paid).toFixed(2) }}</td>
                <td class="px-4 py-2">
                  <button
  v-if="!ticket.has_rated"
  @click="openRatingModal(ticket.event_id)"
  class="bg-blue-500 text-white px-3 py-1 rounded hover:bg-blue-600"
>
  Rate
</button>

<span v-else class="text-gray-500 text-sm">Rated</span>

                </td>
                <td class="px-4 py-2"> <button
                    @click="openCheckinCodesModal(ticket)"
                    class="bg-blue-600 text-white px-3 py-1 rounded hover:bg-indigo-600"
                  >
                    View Codes
                  </button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
        <div v-else class="text-center text-gray-500 mt-8">
          You haven't purchased any tickets yet.
        </div>
      </div>
    </div>

    <div v-if="showRating" class="fixed inset-0 bg-white bg-opacity-50 flex items-center justify-center z-50">
      <div class="bg-white rounded-lg shadow-lg p-6 w-full max-w-sm relative">
        <button @click="cancelRating" class="absolute top-2 right-2 text-gray-500 hover:text-gray-800 text-xl">✕</button>
        <h2 class="text-xl font-bold mb-2">Rate Event</h2>
        <div v-for="category in categories" :key="category.rating_category_id" class="mb-4">
          <div class="font-semibold">{{ category.rating_category_name }}</div>
          <div class="flex gap-1 text-yellow-400">
            <button
              v-for="star in 5"
              :key="star"
              @click="setRating(category.rating_category_id, star)"
              class="focus:outline-none"
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 20 20"
                fill="currentColor"
                :class="[
                  'w-6 h-6 cursor-pointer',
                  category.current_rating >= star ? 'text-yellow-400' : 'text-gray-300'
                ]"
              >
                <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.286 3.966a1 1 0 00.95.69h4.178c.969 0 1.371 1.24.588 1.81l-3.385 2.46a1 1 0 00-.364 1.118l1.287 3.966c.3.921-.755 1.688-1.539 1.118l-3.385-2.46a1 1 0 00-1.175 0l-3.385 2.46c-.784.57-1.838-.197-1.539-1.118l1.287-3.966a1 1 0 00-.364-1.118l-3.385-2.46c-.784-.57-.38-1.81.588-1.81h4.178a1 1 0 00.95-.69l1.286-3.966z" />
              </svg>
            </button>
          </div>
        </div>
        <div v-if="submitError" class="text-red-500 text-sm mt-4">{{ submitError }}</div>
        <div class="flex justify-between mt-6">
          <button @click="cancelRating" class="text-gray-600 hover:text-gray-800">Cancel</button>
          <button @click="submitRating" :disabled="submitting" class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 disabled:opacity-50">
            {{ submitting ? 'Submitting...' : 'Submit' }}
          </button>
        </div>
      </div>
    </div>

    <div v-if="showCheckinCodesModal" class="fixed inset-0 bg-white bg-opacity-50 flex items-center justify-center z-50">
      <div class="bg-white rounded-lg shadow-lg p-6 w-full max-w-sm relative">
        <button @click="closeCheckinCodesModal" class="absolute top-2 right-2 text-gray-500 hover:text-gray-800 text-xl">✕</button>
        <h2 class="text-xl font-bold mb-2">Check-in Codes for "{{ currentCheckinEventTitle }}"</h2>

        <div v-if="currentCheckinCodes && currentCheckinCodes.length > 0">
          <p class="mb-2 text-gray-700">Please present these codes for check-in at the event:</p>
          <ul class="list-disc list-inside space-y-2">
            <li v-for="(code, index) in currentCheckinCodes" :key="index"
                class="font-mono text-sm bg-gray-100 p-2 rounded break-all flex items-center justify-between">
              {{ code }}
              <button @click="copyCode(code)" class="ml-4 text-blue-500 hover:text-blue-700 text-xs">
                Copy
              </button>
            </li>
          </ul>
        </div>
        <div v-else class="text-gray-600 mt-4">No check-in codes available for this event purchase.</div>

        <div class="flex justify-end mt-6">
          <button @click="closeCheckinCodesModal" class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">Close</button>
        </div>
      </div>
    </div>

  </div>
</template>

<script setup>
import { ref, computed, watch } from 'vue';
import { useRouter } from 'vue-router';
import { useSanctumAuth, useSanctumClient } from '#imports';

const router = useRouter();
const config = useRuntimeConfig();
const client = useSanctumClient();
const { user } = useSanctumAuth();

definePageMeta({
  layout: 'master',
  middleware: 'sanctum:auth'
});

// Helper to get authentication token
const getAuthToken = () => {
  if (process.client) {
    return localStorage.getItem('user_token');
  }
  return null;
};
const authToken = computed(() => getAuthToken());

const { data: profileResponse, pending: pendingProfile, error: errorProfile, refresh: refreshProfile } = useFetch(`${config.public.apiUrl}/profile`, {
  headers: {
    'Authorization': `Bearer ${authToken.value}`,
  },
  transform: (response) => response.user_information,
  server: false,
  watch: [authToken]
});

const userProfile = computed(() => profileResponse.value);
console.log('Profile Response:', userProfile.value);
// --- Local State for Profile Form ---
const form = ref({
  username: '',
  email: '',
  profile_image: null,
});

const profileImagePreview = ref(`${config.public.baseUrl}/storage/User/default.png`); 
const savingChanges = ref(false);
const saveError = ref(null);
const saveSuccess = ref(null);


// Watch for changes in userProfile and populate form fields
// This watch can now safely access userProfile because it's defined above
watch(userProfile, (newProfile) => {
  if (newProfile) {
    form.value.username = newProfile.username || '';
    form.value.email = newProfile.email || '';
    // Check if profile_image is already a full URL
    if (newProfile.profile_image) {
      if (newProfile.profile_image.startsWith('http')) {
        profileImagePreview.value = newProfile.profile_image;
      } else {
        profileImagePreview.value = `${config.public.baseUrl}/storage/${newProfile.profile_image}`;
      }
    } else {
      profileImagePreview.value = `${config.public.baseUrl}/storage/User/default.png`;
    }
  }
}, { immediate: true });


// --- Fetch User Tickets ---
const { data: ticketsResponse, pending: pendingTickets, error: errorTickets, refresh: refreshTickets } = useFetch(`${config.public.apiUrl}/get-tickets`, {
  headers: {
    'Authorization': `Bearer ${authToken.value}`,
  },
  transform: (response) => response.tickets,
  server: false,
  watch: [authToken]
});
const userTickets = computed(() => ticketsResponse.value);

// Helper function to format date for display
const formatDate = (dateString) => {
  if (!dateString) return '';
  const date = new Date(dateString);
  return date.toLocaleDateString('en-US', { year: 'numeric', month: '2-digit', day: '2-digit' });
};

// Helper for ticket status class (assuming 'bought' is always 'COMPLETED' for display)
const getStatusClass = (status) => {
  return status === 'bought' ? 'bg-green-100 text-green-800' : 'bg-yellow-100 text-yellow-800';
};

// --- User Profile Navigation Functions ---
function goToChangePassword() {
  router.push('/change');
}

function goToRecharge() {
  router.push('/recharge');
}

// --- Handle Profile Image Upload ---
const handleImageUpload = (event) => {
  const file = event.target.files[0];
  if (file) {
    form.value.profile_image = file;
    // Create a preview URL
    const reader = new FileReader();
    reader.onload = (e) => {
      profileImagePreview.value = e.target.result;
    };
    reader.readAsDataURL(file);
  } else {
    form.value.profile_image = null;
    // This line also relies on userProfile being defined
    profileImagePreview.value = userProfile.value?.profile_image
      ? `${userProfile.value.profile_image}`
      : 'https://i.pravatar.cc/60';
  }
};

// --- Save Changes Function ---
const saveChanges = async () => {
  savingChanges.value = true;
  saveError.value = null;
  saveSuccess.value = null;

  const formData = new FormData();
  // Ensure userProfile.value is not null before comparing
  if (form.value.username !== userProfile.value?.username) {
    formData.append('username', form.value.username);
  }
  if (form.value.email !== userProfile.value?.email) {
    formData.append('email', form.value.email);
  }
  if (form.value.profile_image) {
    formData.append('profile_image', form.value.profile_image);
  }

  // If no changes were made, don't send request
  if (Array.from(formData.keys()).length === 0) {
    saveSuccess.value = 'No changes to save.';
    savingChanges.value = false;
    return;
  }

  formData.append('_method', 'POST'); // Your Laravel route expects POST for updateInfo

  try {
    // IMPORTANT: Correct your API endpoint here from `/api/update` to `/api/profile/update-info`
    const response = await client(`${config.public.baseUrl}/api/update`, {
      method: 'POST', // Use POST method as your Laravel route is POST
      body: formData,
      credentials: 'include',
      headers: {
        // Do NOT set Content-Type for FormData, browser sets it automatically with boundary
      }
    });

    saveSuccess.value = response.message || 'Profile updated successfully!';
    refreshProfile();
    if (user.value) {
      user.value.username = response.user_information.username; // Use response.user_information
      user.value.email = response.user_information.email;     // Use response.user_information
      user.value.profile_image = response.user_information.profile_image; // Use response.user_information
    }
    // Clear the file input state after successful upload
    form.value.profile_image = null;

  } catch (error) {
    console.error('Profile update failed:', error);
    if (error.response && error.response._data && error.response._data.message) {
      saveError.value = error.response._data.message;
      // Handle validation errors specifically
      if (error.response._data.errors) {
        for (const key in error.response._data.errors) {
          saveError.value += ` ${error.response._data.errors[key][0]}`;
        }
      }
    } else {
      saveError.value = 'Failed to update profile. Please try again.';
    }
  } finally {
    savingChanges.value = false;
  }
};

// --- Rating Modal State and Functions (from previous update) ---
const showRating = ref(false);
const submitting = ref(false);
const submitError = ref(null);
const currentEventId = ref(null); // Stores the event_id for the current rating operation

const categories = ref([
  { rating_category_id: 1, rating_category_name: 'Experience', current_rating: 0 },
  { rating_category_id: 2, rating_category_name: 'Price', current_rating: 0 },
  { rating_category_id: 3, rating_category_name: 'Quality', current_rating: 0 },
  { rating_category_id: 4, rating_category_name: 'Service', current_rating: 0 }
]);

async function openRatingModal(eventId) {
  try {
    const { data } = await useFetch(`${config.public.apiUrl}/events/${eventId}`, {
      headers: {
        Authorization: `Bearer ${authToken.value}`
      },
      server: false
    })

    if (!data.value) {
      alert("Failed to load event")
      return
    }

    const eventEnd = new Date(data.value.event_detail.last_event_day)

    if (new Date() <= eventEnd) {
      alert("You can only rate after the event ends.")
      return
    }

    currentEventId.value = eventId
    showRating.value = true

  } catch (e) {
    alert("Error loading event info")
  }
}


function setRating(categoryId, value) {
  const cat = categories.value.find(c => c.rating_category_id === categoryId);
  if (cat) cat.current_rating = value;
}

async function submitRating() {
  if (!currentEventId.value) {
    submitError.value = 'Event ID not set for rating. This should not happen.';
    return;
  }

  const ratingsToSend = categories.value.map(cat => ({
    category_id: cat.rating_category_id,
    value: cat.current_rating
  }));

  const unratedCategory = ratingsToSend.find(r => r.value === 0);
  if (unratedCategory) {
    submitError.value = 'Please rate all categories before submitting.';
    return;
  }
  submitError.value = null;

  submitting.value = true;
  try {
    if (!user.value) {
      alert('You are not logged in. Please log in to submit a rating.');
      router.push('/login');
      return;
    }

    const payload = {
      event_id: currentEventId.value,
      rating: ratingsToSend
    };

    const response = await client(`${config.public.apiUrl}/rating`, {
      method: 'POST',
      body: payload,
      credentials: 'include'
    });

    alert(response.message || 'Thank you for your feedback! Your ratings have been submitted.');
    showRating.value = false;
    refreshTickets(); // Refresh tickets to update 'Rated' status

  } catch (error) {
    console.error('Rating submission failed:', error);
    if (error.response && error.response._data && error.response._data.message) {
      submitError.value = error.response._data.message;
    } else {
      submitError.value = 'Failed to submit rating. Please try again.';
    }
  } finally {
    submitting.value = false;
  }
}

function cancelRating() {
  showRating.value = false;
}
const showCheckinCodesModal = ref(false); // Controls visibility of the check-in codes modal
const currentCheckinCodes = ref([]); // Stores the list of codes for the selected event
const currentCheckinEventTitle = ref(''); // Stores the title of the event for display

// Function to open the check-in codes modal
function openCheckinCodesModal(ticket) {
  if (ticket.checkin_codes) {
    // Split the comma-separated string from the backend into an array
    currentCheckinCodes.value = ticket.checkin_codes.split(',');
    currentCheckinEventTitle.value = ticket.title;
    showCheckinCodesModal.value = true;
  } else {
    // Should not happen if backend is correctly returning codes
    alert('No check-in codes found for this ticket. Please contact support.');
  }
}

// Function to close the check-in codes modal
function closeCheckinCodesModal() {
  showCheckinCodesModal.value = false;
  currentCheckinCodes.value = []; // Clear codes when closing
  currentCheckinEventTitle.value = ''; // Clear title
}

// Function to copy a code to clipboard
const copyCode = async (code) => {
  try {
    await navigator.clipboard.writeText(code);
    // You could add a small visual feedback here (e.g., a temporary 'Copied!' message)
    alert('Check-in code copied to clipboard!');
  } catch (err) {
    console.error('Failed to copy text: ', err);
    alert('Failed to copy code. Please copy manually.');
  }
};
</script>

