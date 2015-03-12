`import Em from 'ember'`
`import DefaultValues from '../mixins/default-values'`
`import DatesMixin from '../mixins/dates'`

class BadgeController extends Em.Controller with DefaultValues, DatesMixin
  photo: null
  fullName: ''
  jobTitle: ''
  selectedSex: null
  selectedHairColor: null
  selectedHeight: null
  selectedLevel: null
  downloadWidth: 1920
  downloadHeight: 1200
  defaultSize: null
  # lockAspectRatio: true
  serialNum: 'A XXXXXX'
  idIsChecked: false

  +computed photo, fullName, jobTitle, selectedSex, selectedHairColor, selectedHeight, selectedLevel, serialNum
  summaryInfo: ->
    photo: @photo
    fullName: @fullName
    jobTitle: @jobTitle
    selectedSex: @selectedSex
    selectedHairColor: @selectedHairColor
    selectedHeight: @selectedHeight
    selectedLevel: @selectedLevel
    serialNum: @serialNum

  +computed photo
  photoIsPresent: ->
    @photo is not null

  # +observer defaultSize
  # defaultSizeDidChange: ->
  #   sizes = @defaultSize.split('-')[0]
  #   sizes = sizes.split('x')
  #   @downloadWidth = +sizes[0]
  #   @downloadHeight = +sizes[1]

  actions:
    uploadPhoto: ->
      reader = new FileReader()
      reader.readAsDataURL()

    deletePhoto: ->
      @photo = null

    # correctH: ->
    #   @downloadHeight = Math.round(@downloadWidth * 10 / 16) if @lockAspectRatio

    # correctW: ->
    #   @downloadWidth = Math.round(@downloadHeight * 16 / 10) if @lockAspectRatio

    downloadBadge: ->
      @_checkCaptcha =>
        filename = @fullName
        filename = 'defaultName' unless filename
        @_cloneCanvas($('.canvas')[0], @downloadWidth, @downloadHeight).toBlob (blob) =>
          saveAs blob, "#{filename}-badge-aos19x.png".dasherize()

    printBadge: ->
      @_checkCaptcha ->
        window.print()

  _checkCaptcha: (callback) ->
    unless @idIsChecked
      formData = $('form[name=captcha]').serialize()
      Em.$.post('api/server.php', formData).then (res) =>
        if res.success is true
          serialNum = res.serial_num
          serialNum = "0#{serialNum}" if serialNum < 100000
          @serialNum = "A #{serialNum}"
          @idIsChecked = true
          callback()
        else
          alert('Something went wrong! Please try again!')
    else
      callback()

  _cloneCanvas: (oldCanvas, width = 1920, height = 1200) ->
    newCanvas = document.createElement('canvas')
    newCanvas.width = width
    newCanvas.height = height
    ctx = newCanvas.getContext('2d')
    ctx.drawImage oldCanvas, 0, 0, width, height
    newCanvas

`export default BadgeController`
