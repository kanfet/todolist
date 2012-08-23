class Todolist.Views.Main extends Backbone.View

  initialize: (options) ->
    options.router.on('route:login', @showLoginForm, @)
    options.router.on('route:register', @showRegisterForm, @)
    options.router.on('route:tasks', @showTasks, @)

  showLoginForm: ->
    if Todolist.current_user
      Backbone.history.navigate('tasks', trigger: true)
    else
      @loginForm = new Todolist.Views.LoginForm()
      @$el.html(@loginForm.render().el)

  showRegisterForm: ->
    if Todolist.current_user
      Backbone.history.navigate('tasks', trigger: true)
    else
      @registerForm = new Todolist.Views.RegisterForm()
      @$el.html(@registerForm.render().el)

  showTasks: ->
    if Todolist.current_user
      tasks = new Todolist.Collections.Tasks()
      @tasksView = new Todolist.Views.Tasks(collection: tasks)
      @$el.html(@tasksView.el)
      tasks.fetch()
    else
      Backbone.history.navigate('', trigger: true)