window.Todolist =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  current_user: null # user name
  init: ->
    router = new Todolist.Routers.Main()
    mainView = new Todolist.Views.Main(el: $("#main.container"), router: router)
    navbar = new Todolist.Views.Navbar(el: $('#navbar'), router: router)

    Backbone.history.start(pushState: true)

$(document).ready ->
  Todolist.init()
