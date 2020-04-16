<template>
  <div class="sight-map">
    <div id="map" ref="map"></div>
  </div>
</template>

<script>
  import Vue from "vue"

  const Component = Vue.extend({
    data() {
      return {
        map: null,
        coordinates: {
          lat: 35.6804,
          lng: 139.7690,
        },
      }
    },

    methods: {
      redraw() {
        const coordinates = this.coordinates

        if (!window.google) {
          setTimeout(function() {
            this.redraw()
          }.bind(this), 1000)
          return
        }

        if (coordinates.lat && coordinates.lng) {
          this.map = new window.google.maps.Map(
            this.$refs["map"], {
              center: this.coordinates,
              zoom: 18,
              disableDefaultUI: true,
              zoomControl: true,
            }
          )

          new window.google.maps.Marker({
            position: this.coordinates,
            map: this.map
          })
        }
      }
    },

    mounted() {
      this.unsubscribe = this.$store.subscribe((mutation, state) => {
        if (mutation.type === "SET_COORDINATES") {
          this.coordinates.lat = this.$store.state.coordinates.lat
          this.coordinates.lng = this.$store.state.coordinates.lng
          this.redraw()
        } else if (mutation.type == "SET_SIGHT_SELECTED_PLACE") {
          const selectedPlace = this.$store.state.sight.selectedPlace
          const placeCoords = selectedPlace.coordinates
          this.coordinates.lat = placeCoords.lat
          this.coordinates.lng = placeCoords.lng
          this.redraw()
        }
      })

      this.redraw()
    },

    beforeDestroy() {
      this.unsubscribe()
    },
  })

  export default Component
</script>

<style scoped>
  #map {
    height: 150px;
  }

  @screen sm {
    #map {
      height: 300px;
    }
  }
</style>
