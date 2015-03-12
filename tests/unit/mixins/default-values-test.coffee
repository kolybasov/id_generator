`import Ember from 'ember'`
`import DefaultValuesMixin from 'clitest/mixins/default-values'`

module 'DefaultValuesMixin'

# Replace this with your real tests.
test 'it works', ->
  DefaultValuesObject = Ember.Object.extend DefaultValuesMixin
  subject = DefaultValuesObject.create()
  ok subject
