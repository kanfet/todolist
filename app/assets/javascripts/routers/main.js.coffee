class Todolist.Routers.Main extends Backbone.Router

  routes:
    '': "login"
    'register': "register"
    'tasks': "tasks"

  initialize: ->
    @.on("all", -> console.log arguments)