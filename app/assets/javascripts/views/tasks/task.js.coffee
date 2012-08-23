class Todolist.Views.Task extends Backbone.View

  template: JST["tasks/task"]

  events:
    "click #delete-task": "deleteTask"
    "click #edit-task": "editTask"
    "click #cancel-edit-task": "cancelEditTask"

  render: ->
    @$el.html(@template(task: @model))
    @

  deleteTask: (event) ->
    event.preventDefault()

    @model.destroy
      success: =>
        @$el.remove()
        @.unbind()

  editTask: (event) ->
    event.preventDefault()
    @$('#display-section').addClass("hidden")
    @$('#edit-section').removeClass("hidden")

  cancelEditTask: (event) ->
    event.preventDefault()
    @$('#display-section').removeClass("hidden")
    @$('#edit-section').addClass("hidden")