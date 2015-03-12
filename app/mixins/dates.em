`import Em from 'ember'`

mixin DatesMixin
  +computed
  dates: ->
    "#{moment().format('YYYYMMMDD')}/#{moment().add(4, 'years').format('YYYYMMMDD')}"

`export default DatesMixin`
