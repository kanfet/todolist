class Todolist.Routers.Main extends Backbone.Router

  routes:
    '': "login"
    'tasks': "tasks"

  initialize: ->
    @.on("all", -> console.log arguments)