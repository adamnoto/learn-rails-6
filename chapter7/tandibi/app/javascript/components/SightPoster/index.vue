<template>
  <div id="sight">
    <input type="hidden" name="post[sight_place_id]"
      :value="selectedPlace.id">

    <PlaceFinder/>

    <div class="block sm:hidden">
      <PlaceList/>
      <div class="spaced">&nbsp;</div>
      <Map/>
    </div>

    <div class="hidden sm:flex">
      <div class="w-2/3">
        <Map/>
      </div>

      <div class="w-1/3">
        <PlaceList/>
      </div>
    </div>
  </div>
</template>

<script>
  import Map from "./Map"
  import PlaceFinder from "./PlaceFinder"
  import PlaceList from "./PlaceList"

  export default {
    components: {
      Map,
      PlaceFinder,
      PlaceList
    },

    computed: {
      selectedPlace() {
        return this.$store.state.sight.selectedPlace || {}
      }
    }
  }
</script>

<style scoped>
  .spaced {
    @apply mt-1 mb-1;
    font-size: 0;
  }
</style>
