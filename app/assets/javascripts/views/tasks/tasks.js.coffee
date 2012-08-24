class Todolist.Views.Tasks extends Backbone.View

  template: JST['tasks/tasks']

  events:
    "click #sort-date": "sortByDate"
    "click #sort-priority": "sortByPriority"

  initialize: ->
    @sortByDateDirection = null
    @sortByPriorityDirection = null
    @collection.on('reset', @render, @)
    @collection.on('change', @refreshList, @)
    @collection.on('add', @refreshList, @)

  render: ->
    if @sortByDateDirection
      dateSortClass = "sorting-#{@sortByDateDirection}"
    else
      dateSortClass = "sorting"
    if @sortByPriorityDirection
      prioritySortClass = "sorting-#{@sortByPriorityDirection}"
    else
      prioritySortClass = "sorting"
    @$el.html(@template(dateSortClass: dateSortClass, prioritySortClass: prioritySortClass))
    newTaskForm = new Todolist.Views.TaskForm(collection: @collection, model: new Todolist.Models.Task())
    @$el.append(newTaskForm.render().el)
    for task in @collection.models
      @appendTask(task)
    @$('[data-behavior="datepicker"]').datepicker(format: 'yyyy-mm-dd', weekStart: 1, autoclose: true)
    @

  appendTask: (task) ->
    taskView = new Todolist.Views.Task(model: task)
    @$el.append(taskView.render().el)

  sortByDate: (event) ->
    @sortByDateDirection = @_toggleDirection(@sortByDateDirection)
    @refreshList()

  sortByPriority: (event) ->
    @sortByPriorityDirection = @_toggleDirection(@sortByPriorityDirection)
    @refreshList()

  refreshList: ->
    @collection.fetch({data: {date_sort: @sortByDateDirection, priority_sort: @sortByPriorityDirection}})

  _toggleDirection: (direction) ->
    if direction == 'desc'
      return 'asc'
    else
      return 'desc'