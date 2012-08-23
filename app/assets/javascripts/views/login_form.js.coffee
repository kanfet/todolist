class Todolist.Views.LoginForm extends Backbone.View

  template: JST["users/login_form"]

  events:
    "submit form": "login"

  render: ->
    @$el.html(@template())
    @$('.alert').hide()
    @

  login: (event) ->
    event.preventDefault()

    session = new Todolist.Models.Session()
    session.save(
      { username: @$('#username').val(), password: @$('#password').val() },
      success: (model, response) ->
        Backbone.history.navigate('tasks', trigger: true)
      error: (model, response) ->
        @$('.alert').html(JSON.parse(response.responseText)['errors']).show()
      wait: true
    )