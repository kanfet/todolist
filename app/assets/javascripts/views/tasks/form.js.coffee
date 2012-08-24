class Todolist.Views.TaskForm extends Backbone.View

  template: JST['tasks/form']

  events:
    "click #add-task": "addTask"

  render: ->
    @el.id = "new_task"
    @$el.html(@template(task: @model))
    @

  addTask: (event) ->
    event.preventDefault()

    attrs = {
      title: @$('input[name="title"]').val()
      due_date: @$('input[name="due_date"]').val()
      priority: @$('select[name="priority"]').val()
      completed: @$('input[name="completed"]:checked').val()
    }

    @collection.create(
      attrs
      wait: true
      error: (model, response) =>
        errors = JSON.parse(response.responseText)['errors']
        for field, err of errors
          @$("[name='#{field}']").siblings('.help-inline').text(err.join(', '))
          @$("[name='#{field}']").parents('.control-group').addClass('error')
    )