class Todolist.Views.Navbar extends Backbone.View

  template: JST['navbar']

  events:
    "click #logout": 'logout'
    "click .brand": 'home'

  initialize: (options) ->
    options.router.on('all', @render, @)

  render: ->
    @$el.html(@template())
    @

  logout: (event) ->
    event.preventDefault()

    session = new Todolist.Models.Session({id: Todolist.current_user})
    session.destroy
      success: ->
        Todolist.current_user = null
        Backbone.history.navigate('', trigger: true)
      wait: true

  home: (event) ->
    event.preventDefault()
    Backbone.history.navigate('', trigger: true)