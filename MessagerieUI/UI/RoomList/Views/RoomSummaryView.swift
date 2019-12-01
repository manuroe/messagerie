//
//  RoomSummaryView.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 01/12/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import SwiftUI

struct RoomSummaryView: View {
    let summary: RoomSummary

    var body: some View {
        HStack {
            AvatarView(avatar: summary.avatar, width: 56, height: 56)

            VStack(alignment: .leading) {
                Text(summary.displayname)
                    .font(.system(size: 16, weight: .medium))
                    .lineLimit(1)

                summary.lastMessage.map {
                    messageContentView(messageContent: $0.content)
                }
            }
        }
    }

    func messageContentView(messageContent: MessageContent) -> AnyView {
        switch messageContent {
        case .text(let message):
            return AnyView(
                Text(message)
                    .font(.system(size: 14))
                    .lineLimit(3)
            )
        case .image( _):
            return AnyView(
                //MessageImageView(urlString: imageModel.url)
                Text("Image")
            )

        case .unsupported( _):
            return AnyView(
                //MessageTextView(message: message)
                Text("Unsupported")
            )

        // EXPERIMENTAL
        case .html( _):
            return AnyView(
                //MessageHtmlView(html: body)
                Text("Html")
            )
        case .widget( _):
            return AnyView(
                //MessageWidgetView(url: url)
                Text("Widget")
            )
        }
    }
}
