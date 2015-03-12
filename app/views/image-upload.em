`import Em from 'ember'`

class ImageUploadView extends Ember.TextField
  tagName: 'input'
  attributeBindings: ['name']
  classNames: ['form-control']
  type: 'file'
  file: null
  change: (e) ->
    reader = new FileReader()
    reader.onload = (e) =>
      @file = e.target.result
    reader.readAsDataURL(e.target.files[0])

`export default ImageUploadView`
