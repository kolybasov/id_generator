`import Em from 'ember'`
`import DatesMixin from '../mixins/dates'`

class CanvasBadgeComponent extends Em.Component with DatesMixin
  tagName: 'canvas'
  classNames: ['dashed', 'canvas']
  attributeBindings: ['width', 'height']
  width: 1920
  height: 1200
  data: null
  ctx: null
  bg: null
  banner: null
  shieldLogo: null
  qr: null
  assetsAreLoaded: 0

  didInsertElement: ->
    @ctx = @element.getContext('2d')
    scaleW = @.$().css('width') / @width
    scaleH = @.$().css('height') / @height
    @ctx.scale(scaleW,scaleH)
    @_loadAssets().then =>
      @_draw()


  +observer data
  redraw: ->
    @_clear()
    @_draw()

  _draw: ->
    @_drawBg()
    @_drawImg(@banner, 20, 15)
    @_drawImg(@shieldLogo, 991, 447)
    @_drawImg(@qr, 1546, 653, 275, 275)
    @_drawStaticText()
    @_drawPhoto()
    @_drawFullName()
    @_drawLevel()
    @_drawJobTitle()
    @_drawSex()
    @_drawHair()
    @_drawHeight()
    @_drawDates()
    @_drawSerialNum()


  _loadAssets: ->
    new Ember.RSVP.Promise (resolve, reject) =>
      # Images
      @bg = new Image()
      @bg.src = 'img/bg.png'
      @banner = new Image()
      @banner.src = 'img/banner.png'
      @shieldLogo = new Image()
      @shieldLogo.src = 'img/shield_logo.png'
      @qr = new Image()
      @qr.src = 'img/qr.png'
      # Fonts

      # Event handlers
      @shieldLogo.onload = =>
        _checkReadiness()
      @bg.onload = =>
        _checkReadiness()
      @banner.onload = =>
        _checkReadiness()
      @qr.onload = =>
        _checkReadiness()
      _checkReadiness = =>
        @assetsAreLoaded++
        resolve() if @assetsAreLoaded is 4

  _drawPhoto: ->
    photo = @data.photo
    photo ?= 'img/photo.jpg'
    img = new Image()
    img.src = photo
    img.onload = =>
      @_drawImg img, 73, 419, 545, 720

  _drawBg: ->
    ptrn = @ctx.createPattern @bg, 'repeat'
    @ctx.fillStyle = ptrn
    @ctx.fillRect 0, 0, @width, @height

  _drawImg:(img, x, y, w = 0, h = 0) ->
    if (w is 0) or (h is 0)
      @ctx.drawImage img, x, y
    else
      @ctx.drawImage img, x, y, w, h

  _drawText: ({str, x, y, size, fontFamily, color, maxWidth, rotate} = {}) ->
    size ?= 34
    fontFamily ?= 'US101'
    color ?= '#000'
    maxWidth ?= 400
    rotate ?= false
    bold = ''

    @ctx.save()
    if rotate
      @ctx.translate(1760,1200)
      @ctx.rotate(-Math.PI / 2)
      bold = 'bold'
    @ctx.fillStyle = color
    @ctx.textBaseline = 'top'
    @ctx.font = "#{bold} #{size}px #{fontFamily}"
    @ctx.fillText str.toUpperCase(), x, y, maxWidth
    @ctx.restore()

  _drawFullName: ->
    fullName = @data.fullName
    fullName = 'Philip J. Coulson' if fullName is ''
    wordsCount = fullName.split(' ').length
    lastName = fullName.split(' ')[wordsCount - 1]
    firstName = fullName.replace(lastName, '')
    @_drawText
      str: "#{lastName},"
      x: 772
      y: 396
      size: 124
    @_drawText
      str: firstName
      x: 772
      y: 396 + 104
      size: 124

  _drawLevel: ->
    lvl = @data.selectedLevel
    lvl ?= 8
    @_drawText
      str: "LEVEL #{lvl}"
      x: 1450
      y: 388
      size: 160

  _drawJobTitle: ->
    @_drawText
      str: @data.jobTitle || 'Field Officer'
      x: 772
      y: 678
      size: 88

  _drawSex: ->
    sex = @data.selectedSex
    sex ?= 'M'
    @_drawText
      str: sex[0]
      x: 772
      y: 815
      size: 88

  _drawHair: ->
    color = @data.selectedHairColor
    color ?= 'BRN'
    @_drawText
      str: color
      x: 772 + 95
      y: 815
      size: 88
      maxWidth: 120

  _drawHeight: ->
    height = @data.selectedHeight
    height ?= '4-00'
    @_drawText
      str: height
      x: 772 + 245
      y: 815
      size: 88

  _drawDates: ->
    @_drawText
      str: @dates
      x: 772
      y: 950
      size: 88
      maxWidth: 740

  _drawSerialNum: ->
    @_drawText
      str: @data.serialNum
      x: 1320
      y: 1080
      color: '#69090C'
      size: 98
      fontFamily: 'Ocrb'
      maxWidth: 600

  _drawStaticText: ->
    @_drawText
      str: 'Title'
      x: 772
      y: 653
      fontFamily: 'Ocrb'
    @_drawText
      str: 'Sex'
      x: 772
      y: 794
      fontFamily: 'Ocrb'
    @_drawText
      str: 'Hair'
      x: 772 + 95
      y: 794
      fontFamily: 'Ocrb'
    @_drawText
      str: 'Height'
      x: 772 + 245
      y: 794
      fontFamily: 'Ocrb'
    @_drawText
      str: 'issue date/exp date'
      x: 772
      y: 929
      fontFamily: 'Ocrb'
    @_drawText
      str: 'card'
      x: 1220
      y: 1090
      fontFamily: 'Ocrb'
    @_drawText
      str: 'ser no'
      x: 1220 - 40
      y: 1090 + 34
      fontFamily: 'Ocrb'
    @_drawText
      str: 'Loss of this card must be reported immediately'
      x: 145
      y: 100
      size: 28
      fontFamily: 'Arial'
      rotate: true
      maxWidth: 635

  _clear: ->
    @ctx.clearRect 0, 0, @width, @height

`export default CanvasBadgeComponent`
