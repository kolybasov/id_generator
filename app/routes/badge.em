`import Em from 'ember'`

class BadgeRoute extends Em.Route
  model: ->
    Em.$.getJSON('api/server.php').then (res) ->
      res

  setupController: (controller, model) ->
    controller.badgesCreated = model.badgesCreated
    model.badgeId = "0#{model.badgeId}" if model.badgeId < 100000
    controller.serialNum = "A #{model.badgeId}"

`export default BadgeRoute`
