`import Em from 'ember'`

mixin DefaultValuesMixin
  sex: ['Male', 'Female', 'Other']

  hairColor: [
    {
      full: 'Black'
      short: 'BLK'
    },
    {
      full: 'Brown'
      short: 'BRN'
    },
    {
      full: 'Blonde'
      short: 'BLD'
    },
    {
      full: 'Red'
      short: 'RED'
    },
    {
      full: 'Gray'
      short: 'GRY'
    },
    {
      full: 'White'
      short: 'WHT'
    },
    {
      full: 'Odd'
      short: 'ODD'
    }
  ]

  level: [1..10]

  +computed
  height: ->
    result = []
    [4..7].forEach (firstNum) ->
      [0..12].forEach (secondNum) ->
        sn = if secondNum < 10 then "0#{secondNum}"  else secondNum
        result.push "#{firstNum}-#{sn}"
    result

  sizes: [
    '1200 x 760 - Facebook',
    '880 x 557 - Twitter',
    '510 x 323 - Instagram',
    '324 x 204 - ID Size'
  ]

`export default DefaultValuesMixin`
