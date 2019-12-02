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
        HStack(alignment: .top) {
            AvatarView(avatar: summary.avatar, width: 56, height: 56)

            VStack(alignment: .leading) {
                HStack {
                    Text(summary.displayname)
                        .font(.headline)
                        .lineLimit(1)

                    Spacer()

                    Text(self.dateString(for: summary.lastMessageTs))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                summary.lastMessage.map {
                    messageContentView(senderDisplayName: $0.senderDisplayName, messageContent: $0.content)
                }
            }
        }
    }

    func messageContentView(senderDisplayName: String, messageContent: MessageContent) -> AnyView {
        switch messageContent {
        case .text(let message):
            return AnyView((
                    Text("\(senderDisplayName) - ")
                        .font(.subheadline)
                    + Text(message)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    )
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

    // TODO: To externalise
    func dateString(for timestamp: UInt64) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"

        let date = Date(timeIntervalSince1970: TimeInterval(timestamp) / 1000)

        let oneDayAgo = Date(timeIntervalSinceNow: (-60 * 60 * 24))
        let oneWeekAgo = Date(timeIntervalSinceNow: (-60 * 60 * 24 * 7))
        if date > oneDayAgo {
            formatter.dateStyle = .none
            formatter.timeStyle = .short
        }
        else if date < oneWeekAgo {
            formatter.dateStyle = .short
            formatter.timeStyle = .none
        }

        return formatter.string(for: date) ?? ""
    }

}
