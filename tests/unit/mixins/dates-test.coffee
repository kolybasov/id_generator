`import Ember from 'ember'`
`import DatesMixin from 'clitest/mixins/dates'`

module 'DatesMixin'

# Replace this with your real tests.
test 'it works', ->
  DatesObject = Ember.Object.extend DatesMixin
  subject = DatesObject.create()
  ok subject
