function handleError(commit, error) {
  const message = error.message || error.info.error_description
  commit('setError', message)
}

const actions = {

}

export default actions
