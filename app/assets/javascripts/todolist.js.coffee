window.Todolist =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    router = new Todolist.Routers.Main()
    mainView = new Todolist.Views.Main(el: $("#main.container"), router: router)

    Backbone.history.start(pushState: true)

$(document).ready ->
  Todolist.init()
