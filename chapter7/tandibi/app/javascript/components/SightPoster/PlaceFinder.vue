<template>
  <div class="sight-place-finder">
    <input type="text"
      placeholder="Find place...">
  </div>
</template>

<script>
  import Vue from "vue"

  const Component = Vue.extend({
  })

  export default Component
</script>

<style scoped>
  input {
    @apply bg-dark-700 text-xl;
    @apply mb-2;
    width: 100%;
  }
</style>
