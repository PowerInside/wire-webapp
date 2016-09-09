importScripts("jimp.min.js");

self.addEventListener("message", function(e) {
  var data = e.data;

  Jimp.read(data.message).then(function (image) {
    var maxSize = 1448;

    if (image.bitmap.width > maxSize || image.bitmap.height > maxSize) {
      image.scaleToFit(maxSize, maxSize)
    }

    if (image.bitmap.data.length > 5 * 1024) {
      image.quality(75);
    }

    image.getBuffer(Jimp.AUTO, function (err, src) {
      self.postMessage({
        id: data.id,
        message: src
      });
    });
  });
});
