window.PRUEBA = {
  init: function() {
      console.log("This is a message")
  },

  task: {
    index: {
      setup: function() {
        console.log("You are in the index page")
      }
    }
  }
}

document.addEventListener("turbo:load", () => {
  PRUEBA.init();
  // PRUEBA.task.index.setup();
})
