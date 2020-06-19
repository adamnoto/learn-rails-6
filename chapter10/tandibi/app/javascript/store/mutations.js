const mutations = {
  SET_ERROR(state, error) {
    state.error = error
  },

  SET_COORDINATES(state, [lng, lat]) {
    state.coordinates.lng = lng
    state.coordinates.lat = lat
  },

  SET_SIGHT_KEYWORD(state, kw) {
    state.sight.keyword = kw
  },

  SET_SIGHT_PLACES(state, places) {
    state.sight.places = places
  },

  SET_SIGHT_SELECTED_PLACE(state, place) {
    state.sight.selectedPlace = place
  },

  RESET(state) {
    state.error = null

    state.coordinates = {
      lat: null,
      lng: null,
    }

    state.sight = {
      keyword: "",
      places: [],
      selectedPlace: null,
    }
  }
}

export default mutations
