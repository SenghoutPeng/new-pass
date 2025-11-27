export default defineNuxtRouteMiddleware(() => {
  if (process.client) {
    const token = localStorage.getItem('org_token')
    if (!token) {
      console.log('Redirecting: No org token found.')
      return navigateTo('/organization/login')
    }
  }
})