class Todolist.Views.Main extends Backbone.View

  initialize: (options) ->
    options.router.on('route:login', @showLoginForm, @)
    options.router.on('route:tasks', @showTasks, @)

  showLoginForm: ->
    @loginForm = new Todolist.Views.LoginForm()
    @$el.html(@loginForm.render().el)

  showTasks: ->
    @tasksView = new Todolist.Views.Tasks()
    @$el.html(@tasksView.render().el)