class Todolist.Views.LoginForm extends Backbone.View

  template: JST["users/login_form"]

  events:
    "submit form": "login"
    "click #register": 'register'

  render: ->
    @$el.html(@template())
    @$('.alert').hide()
    @

  login: (event) ->
    event.preventDefault()

    username = @$('#username').val()
    password = @$('#password').val()

    session = new Todolist.Models.Session()
    session.login(username, password,
      (model, response) =>
        @$('.alert').html(JSON.parse(response.responseText)['errors']).show()
    )

  register: (event) ->
    event.preventDefault()
    Backbone.history.navigate('register', trigger: true)