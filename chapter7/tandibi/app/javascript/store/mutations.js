const mutations = {
  SET_ERROR(state, error) {
    state.error = error
  },

  SET_SIGHT_KEYWORD(state, kw) {
    state.sight.keyword = kw
  },

  RESET(state) {
    state.error = null
    state.sight = {
      keyword: ""
    }
  }
}

export default mutations
