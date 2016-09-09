#
# Wire
# Copyright (C) 2016 Wire Swiss GmbH
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see http://www.gnu.org/licenses/.
#

window.z ?= {}
z.util ?= {}

class z.util.Worker
  constructor: (uri) ->
    worker = new window.Worker uri
    worker.onmessage = (event) ->
      data = event.data
      callback = callbacks[data.id]

      if callback?
        callback data.message
        delete callbacks[callback_id]

    callback_id = 0
    callbacks = {}

    post_message = (message, callback) ->
      callbacks[callback_id] = callback
      worker.postMessage
        id: callback_id
        message: message
      callback_id = callback_id + 1

    @post = (data) ->
      return new Promise (resolve) ->
        post_message data, resolve
