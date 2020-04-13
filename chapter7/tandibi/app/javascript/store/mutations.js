const mutations = {
  SET_ERROR(state, error) {
    state.error = error
  },

  RESET(state) {
    state.error = null
  }
}

export default mutations
