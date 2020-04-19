window.toggleModal = (modalClass) => {
  const modalIdentifier = `[data-modal-class=${modalClass}]`
  const body = document.querySelector("body")
  const modal = document.querySelector(modalIdentifier)

  modal.classList.toggle("opacity-0")
  modal.classList.toggle("pointer-events-none")
  body.classList.toggle("modal-active")
}

window.closeAllModal = () => {
  document.body.classList.remove("modal-active")
  document.querySelectorAll(".modal").forEach((modal) => {
    if (!modal.classList.contains("opacity-0")) {
      modal.classList.add("opacity-0")
      modal.classList.add("pointer-events-none")
    }
  })
}

document.addEventListener("DOMContentLoaded", () => {
  document.addEventListener("click", (e) => {
    if (e.target) {
      var classes = e.target.classList
      const modalElm = e.target.closest("[data-modal-class]")

      if (!modalElm) { return }

      const modalClass = modalElm.getAttribute("data-modal-class")

      if (classes.contains("js-modal-overlay")) {
        e.preventDefault()
        window.toggleModal(modalClass)
      } else if (e.target.parentElement) {
        var parentClasses = e.target.parentElement.classList
        if (parentClasses.contains("js-modal-close")) {
          e.preventDefault()
          window.toggleModal(modalClass)
        } else if (parentClasses.contains("js-modal-open")) {
          e.preventDefault()
          window.closeAllModal()
          window.toggleModal(modalClass)
        }
      }
    }
  })

  document.addEventListener("keydown", (evt) => {
    evt = evt || window.event
    var key = evt.key || evt.keyCode

    if (key === "Escape" || key === "Esc" || key === 27) {
      window.closeAllModal()
    }
  })
})
