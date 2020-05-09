<template>
  <div class="sight-place-finder">
    <input type="text"
      v-model="keyword"
      v-on:keyup="findPlace"
      placeholder="Find place...">
  </div>
</template>

<script>
  import Vue from "vue"
  import debounce from "lodash/debounce"

  const Component = Vue.extend({
    computed: {
      keyword: {
        get() {
          return this.$store.state.sight.keyword
        },
        set(value) {
          this.$store.commit(
            "SET_SIGHT_KEYWORD",
            value,
          )
        }
      }
    },

    methods: {
      findPlace: debounce(function() {
        this.$store.dispatch("findPlace")
      }, 300)
    }
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
