import Vue from "vue"
import Vuex from "vuex"
import actions from "./actions"
import mutations from "./mutations"

Vue.use(Vuex)

const isDev = process.env.NODE_ENV !== "production"

const store = new Vuex.Store({
  state: {
    error: null,
    coordinates: null,
    sight: null,
  },

  // the only way to change the state
  mutations,

  // perform async actions
  actions,

  // values derived from the state
  getters: {
    hasError: state => state.error ? true : false
  },

  // raise an error if a state is unlawfully mutated
  strict: isDev
})

function resetStore() {
  store.commit("RESET")

  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition((pos) => {
      store.commit("SET_COORDINATES",
        [pos.coords.longitude, pos.coords.latitude])
    })
  }
}

resetStore()
export default store
