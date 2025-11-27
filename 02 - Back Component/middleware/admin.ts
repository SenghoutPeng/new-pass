// middleware/admin.ts

export default defineNuxtRouteMiddleware((to, from) => {
  // Check if the code is running on the client-side (in the browser)
  // `process.client` is a Nuxt-specific global variable that is true on the client
  // and false on the server.
  if (process.client) {
    const token = localStorage.getItem('admin_token');

    if (!token) {
      // If the user is not logged in on the client-side, redirect them.
      // This ensures the redirection happens in the browser and prevents the error.
      console.log('Client-side: Admin token not found, redirecting to login.');
      return navigateTo('/admin/login');
    }
  } else {
    // This block executes on the server-side.
    // We cannot access localStorage here.
    // For server-side rendering, if you need to protect routes,
    // you would typically rely on server-side authentication (e.g., checking cookies)
    // or simply let the API calls to your Laravel backend handle the 401.

    // If you explicitly want to redirect on the server *before* hydration
    // based on an authentication status you can't get from localStorage:
    // You would need to check for the HTTP-only cookie here, but that's complex
    // and usually deferred to the backend.
    // For now, by omitting localStorage, the server-side render proceeds,
    // and the client-side middleware will then handle the redirection
    // once the browser takes over.
    console.log('Server-side: Admin middleware running. localStorage not available.');
  }
});