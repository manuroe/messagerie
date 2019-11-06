//
//  MessageFactory.swift
//  MatrixSUI
//
//  Created by Emmanuel ROHEE on 22/08/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import UIKit

import SwiftMatrixSDK

class MatrixMessageFactory {

    func buildMessage(from event: MXEvent, roomState: MXRoomState, direction: MXTimelineDirection) -> Message? {

        guard let messageContent = self.buildMessageContent(from: event) else {
            return nil
        }

        let senderDisplayName: String = roomState.members.memberName(event.sender) ?? event.sender
        let senderAvatar = roomState.members.member(withUserId: event.sender)?.avatarUrl

        return Message(eventId: event.eventId,
                        sender: event.sender,
                        senderDisplayName: senderDisplayName,
                        senderAvatar: senderAvatar,
                        content:messageContent)
    }


    private func buildMessageContent(from event: MXEvent) -> MessageContent? {

        switch MXEventType(identifier: event.type) {
        case .roomMessage:
            guard let messageType = event.content["msgtype"] as? String else {
                return nil
            }
            return self.buildRoomMessageContent(from: event, messageType: MXMessageType(identifier: messageType))

        case .custom(let eventType):
            return self.buildCustomMessageContent(from: event, customType: eventType)

        default:
            break
        }

        return nil
    }

    private func buildRoomMessageContent(from event: MXEvent, messageType: MXMessageType) -> MessageContent? {
        switch messageType {
        case .text:
// The rendering of this does not work for now
//            if let html = event.content["formatted_body"] as? String {
//                return .html(body: html)
//            }
            return .text(message: event.content["body"] as! String)
        case .image:
            guard var url = event.content["url"] as? String else {
                return .text(message: "## Unsupported image :/")
            }

            if url.hasPrefix("mxc://") {
                url = url.replacingOccurrences(of: "mxc://", with: "https://matrix.org/_matrix/media/r0/thumbnail/") + "?width=320&height=320&method=scale"
            }

            // TODO
            let size = CGSize()

            return .image(imageModel: MessageContentImage(url: url, size: size))
        default:
            return .text(message: "## Unsupported msgtype: \(messageType)")
        }
    }

    private func buildCustomMessageContent(from event: MXEvent, customType: String) -> MessageContent? {
        switch customType {
        case "im.vector.modular.widgets":
            return self.buildWidgetMessageContent(from: event)
        default:
            return nil
        }
    }

    private func buildWidgetMessageContent(from event: MXEvent) -> MessageContent {
        guard let urlString = event.content["url"] as? String, let url = URL(string: urlString) else {
            return .text(message: "## Unsupported widget :/")
        }

        return .widget(url: url)
    }
}