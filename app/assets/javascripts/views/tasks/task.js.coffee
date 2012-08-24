class Todolist.Views.Task extends Backbone.View

  template: JST["tasks/task"]

  events:
    "click #delete-task": "deleteTask"
    "click #edit-task": "editTask"
    "click #cancel-edit-task": "cancelEditTask"
    "click #update-task": "updateTask"

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
    @_showForm()

  cancelEditTask: (event) ->
    event.preventDefault()
    @_hideForm()

  updateTask: (event) ->
    event.preventDefault()
    attrs = {
      title: @$('input[name="title"]').val()
      due_date: @$('input[name="due_date"]').val()
      priority: @$('select[name="priority"]').val()
      completed: @$('input[name="completed"]:checked').val()
    }
    @model.save(
      attrs
      wait: true
      success: (model, response) =>
        @_hideForm()
      error: (model, response) =>
        errors = JSON.parse(response.responseText)['errors']
        for field, err of errors
          @$("[name='#{field}']").siblings('.help-inline').text(err.join(', '))
          @$("[name='#{field}']").parents('.control-group').addClass('error')
    )

  _hideForm: ->
    @$('.display-section').removeClass("hidden")
    @$('.edit-section').addClass("hidden")

  _showForm: ->
    @$('.display-section').addClass("hidden")
    @$('.edit-section').removeClass("hidden")