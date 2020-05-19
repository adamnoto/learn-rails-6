function handleError(commit, error) {
  const message = error.message || error.info.error_description
  commit('setError', message)
}

const actions = {
  async findPlace({ commit, state }) {
    try {
      const url = new URL("/api/v1/places", window.location.origin)
      url.searchParams.append("keyword", state.sight.keyword)
      url.searchParams.append("lat", state.coordinates.lat)
      url.searchParams.append("lng", state.coordinates.lng)

      const performSearch = async (isRetried) => {
        let response = await fetch(url)
        let data = await response.json()

        if (data.length === 0 && !isRetried) {
          setTimeout(() => { performSearch(true) }, 5000)
        } else {
          commit("SET_SIGHT_PLACES", data)
        }
      }

      await performSearch(false)
    } catch (error) {
      handleError(commit, error)
    }
  }
}

export default actions
