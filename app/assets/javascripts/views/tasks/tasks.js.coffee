class Todolist.Views.Tasks extends Backbone.View

  template: JST['tasks/tasks']

  initialize: ->
    @collection.on('reset', @render, @)
    @collection.on('change', @render, @)
    @collection.on('add', @render, @)

  render: ->
    @$el.html(@template())
    newTaskForm = new Todolist.Views.TaskForm(collection: @collection, model: new Todolist.Models.Task())
    @$el.append(newTaskForm.render().el)
    for task in @collection.models
      @appendTask(task)
    @$('[data-behavior="datepicker"]').datepicker(format: 'yyyy-mm-dd', weekStart: 1, autoclose: true)
    @

  appendTask: (task) ->
    taskView = new Todolist.Views.Task(model: task)
    @$el.append(taskView.render().el)