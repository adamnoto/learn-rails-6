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
      if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition((pos) => {
          const coords = pos.coords
          this.coordinates.lat = coords.latitude
          this.coordinates.lng = coords.longitude

          this.redraw()
        })
      }
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
