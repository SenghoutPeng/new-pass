<template>
  <div class="flex min-h-screen bg-gray-100">
    <div class="flex-1 flex flex-col">
      <main class="flex-1 p-8 overflow-y-auto">
        <h1 class="text-3xl font-bold text-gray-800 mb-6">Create Event</h1>

        <section class="bg-white p-8 rounded-lg shadow-md mb-8">
          <div class="text-center mb-6">
            <div class="text-6xl text-gray-400 mb-4">
              <i class="fas fa-calendar-plus"></i>
            </div>
            <h2 class="text-2xl font-bold text-gray-800 mb-2">Create New Event</h2>
            <p class="text-gray-600">Fill in the form below to create a new event for your organization</p>
          </div>

          <div v-if="message" :class="['p-3 mb-4 rounded-md', messageType === 'success' ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700']">
            {{ message }}
          </div>

          <!-- Event Details -->
          <div class="mb-8">
            <h3 class="text-xl font-bold text-gray-800 mb-4">Event Details</h3>
            <div class="space-y-4">
              <div>
                <label for="eventTitle" class="block text-sm font-medium text-gray-700">Event Title *</label>
                <input type="text" id="eventTitle" v-model="event.title" placeholder="Enter event title" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md sm:text-sm">
              </div>
              <div>
                <label for="eventDescription" class="block text-sm font-medium text-gray-700">Event Description *</label>
                <textarea id="eventDescription" v-model="event.description" rows="3" placeholder="Enter a detailed description of your event" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md sm:text-sm resize-y"></textarea>
              </div>
              <div>
                <label for="eventCategory" class="block text-sm font-medium text-gray-700">Category *</label>
                <select id="eventCategory" v-model="event.event_category_id" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md sm:text-sm">
                  <option value="">Select category</option>
                  <option value="1">Music</option>
                  <option value="2">Sport</option>
                  <option value="3">Conference</option>
                  <option value="4">Art</option>
                </select>
              </div>
              <div>
                <label for="eventLocation" class="block text-sm font-medium text-gray-700">Location *</label>
                <input type="text" id="eventLocation" v-model="event.location" placeholder="Enter event location" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md sm:text-sm">
              </div>
            </div>
          </div>

          <!-- Event Duration and Ticket Info -->
          <div class="mb-8">
            <h3 class="text-xl font-bold text-gray-800 mb-4">Event Duration & Ticket Info</h3>

            <div class="mb-4">
              <label class="block text-sm font-medium text-gray-700">Select Event Duration *</label>
              <select v-model="event.days" @change="updateDays(event.days)" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md sm:text-sm">
                <option :value="1">1 Day</option>
                <option :value="2">2 Days</option>
                <option :value="3">3 Days</option>
              </select>
            </div>

            <div v-for="(day, index) in event.dates" :key="index" class="border rounded-lg p-4 mb-4">
              <h4 class="text-lg font-semibold text-gray-700 mb-2">Day {{ index + 1 }}</h4>
              <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <label class="block text-sm font-medium text-gray-700">Event Date *</label>
                  <input type="date" v-model="event.dates[index].event_date" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md sm:text-sm" />
                </div>
                <div>
                  <label class="block text-sm font-medium text-gray-700">Event Time *</label>
                  <input type="time" v-model="event.dates[index].event_time" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md sm:text-sm" />
                </div>
                <div>
                  <label class="block text-sm font-medium text-gray-700">Ticket Price ($)</label>
                  <input type="number" v-model="event.dates[index].ticket_price" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md sm:text-sm" />
                </div>
                <div>
                  <label class="block text-sm font-medium text-gray-700">Total Tickets</label>
                  <input type="number" v-model="event.dates[index].total_ticket" class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md sm:text-sm" />
                </div>
              </div>
            </div>

            <p class="text-xs text-gray-500 mt-2">
              <i class="fas fa-info-circle mr-1"></i>NEWPASS will charge 5% + $0.28 per ticket.
            </p>
          </div>

          <!-- Banner Upload -->
          <div class="mb-8">
            <h3 class="text-xl font-bold text-gray-800 mb-4">Event Banner</h3>
            <div class="border-2 border-dashed border-gray-300 rounded-lg p-6 text-center cursor-pointer hover:border-indigo-500" @click="triggerFileInput">
              <input type="file" ref="fileInput" @change="handleFileUpload" accept="image/*" class="hidden">
              <div class="text-4xl text-gray-400 mb-2"><i class="fas fa-cloud-upload-alt"></i></div>
              <p class="text-gray-600 mb-1">Click to upload or drag & drop</p>
              <p class="text-gray-500 text-sm">Max size: 2MB. Formats: SVG, PNG, JPG, etc.</p>
              <p v-if="event.bannerFileName" class="text-green-600 mt-2">Uploaded: {{ event.bannerFileName }}</p>
            </div>
          </div>

          <!-- Action Buttons -->
          <div class="flex justify-end space-x-4">
            <button @click="handleCancel" class="px-6 py-2 border border-gray-300 rounded-md text-gray-700 hover:bg-gray-100">Cancel</button>
            <button @click="handleCreateEvent" class="px-6 py-2 bg-indigo-600 text-white rounded-md hover:bg-indigo-700">Create Event</button>
          </div>
        </section>
      </main>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';
const router = useRouter();
const client = useSanctumClient();

definePageMeta({
  layout: 'master',
  middleware: 'org-auth'
})

const event = ref({
  title: '',
  description: '',
  event_category_id: '',
  location: '',
  days: 1,
  dates: [
    { event_date: '', event_time: '', ticket_price: '', total_ticket: '' }
  ],
  banner: '',
});

const fileInput = ref(null);
const message = ref('');
const messageType = ref('');

const showMessage = (msg, type) => {
  message.value = msg;
  messageType.value = type;
  setTimeout(() => {
    message.value = '';
    messageType.value = '';
  }, 5000);
};

const updateDays = (num) => {
  event.value.days = num;
  event.value.dates = Array.from({ length: num }, () => ({
    event_date: '',
    event_time: '',
    ticket_price: '',
    total_ticket: '',
  }));
};

const triggerFileInput = () => {
  fileInput.value?.click();
};

const handleFileUpload = (e) => {
  const file = e.target.files[0];
  const allowed = ['image/svg+xml', 'image/png', 'image/jpeg', 'image/gif', 'image/webp', 'image/avif'];
  const max = 2 * 1024 * 1024;
  if (!file || !allowed.includes(file.type) || file.size > max) {
    showMessage('Invalid or too large file (max 2MB)', 'error');
    fileInput.value.value = '';
    return;
  }
  event.value.bannerFile = file;
  event.value.bannerFileName = file.name;
};

const handleCancel = () => {
  event.value = {
    title: '',
    description: '',
    event_category_id: '',
    location: '',
    days: 1,
    dates: [{ event_date: '', event_time: '', ticket_price: '', total_ticket: '' }],
    banner: '',
  };
  if (fileInput.value) fileInput.value.value = '';
};

const fetchCsrfToken = async () => {
  try {
    const res = await fetch('http://localhost:8000/sanctum/csrf-cookie', {
      method: 'GET',
      credentials: 'include',
    });
    return res.ok;
  } catch (err) {
    showMessage('Network error getting CSRF token', 'error');
    return false;
  }
};

const handleCreateEvent = async () => {
  if (!event.value.title || !event.value.description || !event.value.event_category_id || !event.value.location) {
    return showMessage('Please fill in all required fields.', 'error');
  }

  for (const d of event.value.dates) {
    if (!d.event_date || !d.event_time || !d.ticket_price || !d.total_ticket) {
      return showMessage('Please complete all day details.', 'error');
    }
  }

  if (!event.value.bannerFile) {
    return showMessage('Banner is required.', 'error');
  }

  if (!(await fetchCsrfToken())) return;

  const formData = new FormData();
  formData.append('title', event.value.title);
  formData.append('description', event.value.description);
  formData.append('location', event.value.location);
  formData.append('event_category_id', event.value.event_category_id);

  formData.append('banner', event.value.bannerFile);

  event.value.dates.forEach((d, i) => {
    formData.append(`dates[${i}][event_date]`, d.event_date);
    formData.append(`dates[${i}][event_time]`, d.event_time + ':00');
    formData.append(`dates[${i}][ticket_price]`, d.ticket_price);
    formData.append(`dates[${i}][total_ticket]`, d.total_ticket);
  });

  try {
    const res = await client('http://localhost:8000/api/organization/event-request', {
      method: 'POST',
      body: formData,
      credentials: 'include',
    });
    const data = await res;
    if (res.ok) {
      showMessage(data.message || 'Event created successfully!', 'success');
      handleCancel();
    } else {
      showMessage(data.message || 'Failed to create event.', 'error');
    }
  } catch (err) {
    showMessage('Unexpected error. Try again.', 'error');
  }
};


</script>

<style scoped>
@import url('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css');
</style>
