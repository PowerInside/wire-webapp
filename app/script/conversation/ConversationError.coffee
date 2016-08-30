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
z.conversation ?= {}

class z.conversation.ConversationError
  constructor: (type) ->
    @name = @constructor.name
    @stack = (new Error()).stack
    @type = type or z.conversation.ConversationError::TYPE.UNKNOWN

    @message = switch @type
      when z.conversation.ConversationError::TYPE.NO_CONVERSATION_ID
        'Conversation ID is not defined'
      when z.conversation.ConversationError::TYPE.NOT_FOUND
        'Conversation not found'
      when z.conversation.ConversationError::TYPE.REQUEST_FAILED
        'Conversation related backend request failed'
      else
        'Unknown ConversationError'

  @:: = new Error()
  @::constructor = @
  @::TYPE =
    NO_CONVERSATION_ID: 'z.conversation.ConversationError::TYPE.NO_CONVERSATION_ID'
    NOT_FOUND: 'z.conversation.ConversationError::TYPE.NOT_FOUND'
    REQUEST_FAILURE: 'z.conversation.ConversationError::TYPE.REQUEST_FAILURE'
    UNKNOWN: 'z.conversation.ConversationError::TYPE.UNKNOWN'
