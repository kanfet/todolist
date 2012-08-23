class Todolist.Collections.Tasks extends Backbone.Collection

  model: Todolist.Models.Task

  url: 'api/tasks'