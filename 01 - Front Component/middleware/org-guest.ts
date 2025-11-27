export default defineNuxtRouteMiddleware(() => {
  if (process.client) {
    const token = localStorage.getItem('org_token')          // ← adjust key if needed
    if (token) {
      // User already logged in; keep them out of guest pages
      return navigateTo('/organization/dashboard')
    }
  }
})
