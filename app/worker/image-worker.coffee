importScripts 'jimp.min.js'

maxSize = 1448

self.addEventListener 'message', (e) ->
  data = e.data

  Jimp.read(data.message).then (image) ->

    if image.bitmap.width > maxSize or image.bitmap.height > maxSize
      image.scaleToFit maxSize, maxSize

    if image.bitmap.data.length > 5 * 1024
      image.quality 75

    image.getBuffer Jimp.AUTO, (err, src) ->
      self.postMessage
        id: data.id
        message: src
