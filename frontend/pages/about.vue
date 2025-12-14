<template>
  <div class="bg-[#1D1D1D] text-white">
    <div class="bg-white text-black">
      <div class="h-[400px] w-full bg-gray-300 flex items-center justify-center text-xl text-gray-600">
        <img class="object-cover h-full w-full" src="/image/about.png" alt="Hero Image" />
      </div>

      <section class="text-center px-6 py-10 mx-auto">
        <h2 class="text-2xl font-bold text-[#003366] mb-4">OUR COMPANY</h2>
        <p class="text-gray-700">
          Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sagittis condimentum elit, quis
          mattis leo semper sit amet. Sed porta justo et volutpat bibendum. Nullam id ante et diam efficitur
          consectetur sed eu nisl. Fusce eget venenatis sapien. In vitae ultricies eros, vitae ullamcorper
          lorem...
        </p>
      </section>

      <section class="bg-[#eaf6ff] text-center px-6 py-10  mx-auto">
        <h2 class="text-2xl font-bold text-[#003366] mb-4">OUR GOALS</h2>
        <p class="text-gray-700">
          Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi sagittis condimentum elit, quis
          mattis leo semper sit amet. Sed porta justo et volutpat bibendum...
        </p>
      </section>

      <section class="text-center py-10 px-4">
        <h2 class="text-2xl font-bold text-[#003366] mb-8">ACHIEVEMENTS</h2>
        <div class="flex md:flex-row flex-col justify-center items-center gap-16">
          <div class="flex flex-col items-center">
            <div class="h-12 w-12 bg-gray-300 rounded-full mb-2"></div>
            <p class="mt-2 font-semibold">9M SOLD</p>
          </div>
          <div class="flex flex-col items-center">
            <div class="h-12 w-12 bg-gray-300 rounded-full mb-2"></div>
            <p class="mt-2 font-semibold">12M monthly users</p>
          </div>
          <div class="flex flex-col items-center">
            <div class="h-12 w-12 bg-gray-300 rounded-full mb-2"></div>
            <p class="mt-2 font-semibold">3M monthly events</p>
          </div>
        </div>
      </section>

      <section class="flex flex-col md:flex-row">
        <div class="relative flex-1">
          <div class="w-full h-[250px] bg-gray-300 flex items-center justify-center text-gray-600">Host Image</div>
          <div class="absolute inset-0 flex items-center justify-center bg-black bg-opacity-40 text-white text-xl font-semibold">Host</div>
        </div>
        <div class="relative flex-1">
          <div class="w-full h-[250px] bg-gray-300 flex items-center justify-center text-gray-600">Discover Image</div>
          <div class="absolute inset-0 flex items-center justify-center bg-black bg-opacity-40 text-white text-xl font-semibold">Discover</div>
        </div>
        <div class="relative flex-1">
          <div class="w-full h-[250px] bg-gray-300 flex items-center justify-center text-gray-600">Join Image</div>
          <div class="absolute inset-0 flex items-center justify-center bg-black bg-opacity-40 text-white text-xl font-semibold">Join</div>
        </div>
      </section>
    </div>
  </div>
</template>

<script setup>


definePageMeta({
  layout: 'master'
})
</script>

