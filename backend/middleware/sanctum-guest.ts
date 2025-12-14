// middleware/sanctum-guest.js
export default defineNuxtRouteMiddleware((to, from) => {
  // Client-side only check as localStorage is not available on the server
  if (process.client) {
    const adminToken = localStorage.getItem('admin_token');

    // If an admin token exists, the user is considered logged in.
    // Redirect them away from the login page.
    if (adminToken) {
      // You can redirect to the admin dashboard or any other appropriate page
      return navigateTo('/admin'); // Or whatever your main admin page is
    }
  }
  // If no token exists, allow access to the login page (guest user)
});