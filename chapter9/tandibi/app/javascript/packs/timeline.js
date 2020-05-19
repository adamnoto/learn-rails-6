document.addEventListener("DOMContentLoaded", () => {
  document.addEventListener("click", (evt) => {
    var elm = evt.target
    if (elm && elm.parentElement) {
      var parentElement = elm.parentElement
      var linkElm = parentElement.closest("a")

      if (!linkElm) {
        var lineElm = elm.closest(".line")
        if (lineElm) {
          var postPath = lineElm.getAttribute("data-post-path")

          if (window.location.pathname !== postPath) {
            window.location = postPath
          }
        }
      }
    }
  })
})
