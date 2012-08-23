class Todolist.Views.RegisterForm extends Backbone.View

  template: JST["users/register_form"]

  events:
    "submit form": "register"

  render: ->
    @$el.html(@template())
    @

  register: (event) ->
    event.preventDefault()

    username = @$('#username').val()
    password = @$('#password').val()
    password_confirmation = @$('#password_confirmation').val()
    user = new Todolist.Models.User()
    user.save(
      { username: username, password: password, password_confirmation: password_confirmation }
      success:(model, response) ->
        Backbone.history.navigate('', trigger: true)
      error: (model, response) ->
        errors = JSON.parse(response.responseText)['errors']
        for field in ['username', 'password', 'password_confirmation']
          @$("##{field}").parents('.control-group').removeClass('error')
        for field, err of errors
          @$("##{field}").siblings('.help-inline').text(err.join(', '))
          @$("##{field}").parents('.control-group').addClass('error')
    )