//
//  MessageFactory.swift
//  MatrixSUI
//
//  Created by Emmanuel ROHEE on 22/08/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import UIKit

import SwiftMatrixSDK

struct MatrixMessageFactory {

    let session: MatrixSession

    func buildMessage(from event: MXEvent, roomState: MXRoomState, direction: MXTimelineDirection) -> Message? {
        guard let eventId = event.eventId, let messageContent = self.buildMessageContent(from: event) else {
            return nil
        }

        let senderDisplayName = roomState.members.memberName(event.sender) ?? event.sender ?? ""

        let senderAvatar: String
        if let mxcSenderAvatar = roomState.members.member(withUserId: event.sender)?.avatarUrl {
            senderAvatar = session.urlString(mxcString: mxcSenderAvatar, size: CGSize(width: 40, height: 40)) ?? "https://matrix.org/matrix.png"
        }
        else {
            senderAvatar = "https://matrix.org/matrix.png"
        }

        return Message(eventId: eventId,
                        sender: event.sender,
                        senderDisplayName: senderDisplayName,
                        senderAvatar: senderAvatar,
                        content: messageContent,
                        timestamp: event.ageLocalTs)
    }


    private func buildMessageContent(from event: MXEvent) -> MessageContent? {
        guard let type = event.type else {
            return nil
        }

        let eventType = MXEventType(identifier: type)
        switch eventType {
        case .roomMessage:
            guard let messageType = event.content["msgtype"] as? String else {
                return nil
            }
            return self.buildRoomMessageContent(from: event, messageType: MXMessageType(identifier: messageType))

        case .custom(let eventType):
            return self.buildCustomMessageContent(from: event, customType: eventType)

        default:
            return .unsupported(message: "# \(eventType.identifier)")
        }
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

            // TODO
            url = session.urlString(mxcString: url, size: CGSize(width: 320, height: 320))!
            let size = CGSize()

            return .image(imageModel: MessageContentImage(url: url, size: size))
        default:
            if let body = event.content["body"] as? String {
                return .unsupported(message: body)
            } else {
                return .unsupported(message: "## \(messageType)")
            }
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
