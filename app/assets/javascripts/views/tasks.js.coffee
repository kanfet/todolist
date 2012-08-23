class Todolist.Views.Tasks extends Backbone.View

  render: ->
    @$el.html("<h1>Tasks of #{Todolist.current_user}</h1>")
    @