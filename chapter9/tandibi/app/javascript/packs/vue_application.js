import Vue from 'vue'
import store from "../store"
import SightPoster from '../components/SightPoster'
import { truncate } from "../lib/filters"

Vue.filter("truncate", truncate)

function renderSight() {
  const sightPoster = new Vue({
    store,
    render: h => h(SightPoster)
  }).$mount()

  document.querySelector(".js-sight-poster")
    .appendChild(sightPoster.$el)
}

document.addEventListener('turbolinks:load', () => {
  if (document.querySelector(".js-sight-poster")) {
    renderSight()
  }
})
