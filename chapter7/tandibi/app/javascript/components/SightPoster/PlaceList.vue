<template>
  <div class="places">
    <div v-for="place in sight.places"
      class="place"
      @click="setPlace(place)"
      :class="isSelected(place)"
      :key="place.id">
      <p>{{ place.name | truncate(40) }}</p>
    </div>
  </div>
</template>

<script>
  import Vue from "vue"
  import { mapState } from "vuex"

  const Component = Vue.extend({
    computed: {
      ...mapState(["sight"]),
    },

    methods: {
      setPlace(place) {
        this.$store.commit("SET_SIGHT_SELECTED_PLACE", place)
      },

      isSelected(place) {
        const placeId = place.id
        const selectedPlace = this.sight.selectedPlace
        if (selectedPlace && selectedPlace.id === placeId) {
          return "selected"
        }
      }
    }
  })

  export default Component
</script>

<style scoped>
  .places {
    @apply overflow-x-hidden overflow-y-scroll;
    height: 8em;
    min-height: 8em;
    max-height: 8em;
  }

  .place {
    @apply p-2 overflow-hidden;
    @apply cursor-pointer;
    min-height: 4em;
    height: 4em;
  }

  .place.selected {
    @apply bg-indigo-800;
  }

  .place.selected:hover {
    @apply bg-indigo-700;
  }

  .place:hover {
    @apply bg-dark-600;
    @apply transition duration-100 ease-in;
  }

  @screen sm {
    .places {
      height: 300px;
      max-height: 300px;
      min-height: 300px;
    }

    .place {
      @apply ml-2;
    }
  }
</style>
