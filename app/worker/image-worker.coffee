importScripts 'jimp.min.js'

MAX_SIZE = 1448
MAX_FILE_SIZE = 5 * 1024
COMPRESSION = 75

self.addEventListener 'message', (e) ->
  data = e.data

  Jimp.read(data.message).then (image) ->

    if image.bitmap.width > MAX_SIZE or image.bitmap.height > MAX_SIZE
      image.scaleToFit MAX_SIZE, MAX_SIZE

    if image.bitmap.data.length > MAX_FILE_SIZE
      image.quality COMPRESSION

    image.getBuffer Jimp.AUTO, (err, src) ->
      self.postMessage
        id: data.id
        message: src
