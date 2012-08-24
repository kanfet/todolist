class Todolist.Models.Session extends Backbone.Model

  urlRoot: "api/sessions"

  login: (username, password, errorCallback) ->
    @save(
      { username: username, password: password },
      success: (model, response) ->
        Todolist.current_user = response['user']
        Backbone.history.navigate('tasks', trigger: true)
      error: errorCallback
      wait: true
    )