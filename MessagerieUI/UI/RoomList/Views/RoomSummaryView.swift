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
                HStack(alignment: .bottom) {
                    Text(summary.displayname)
                        .font(.headline)
                        .lineLimit(1)

                    Spacer()

                    Text(self.dateString(for: summary.lastMessageTs))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                summary.lastMessage.map {
                    messageContentView(senderDisplayName: $0.senderDisplayName, messageContent: $0.content)
                }
            }
        }
    }

    func messageContentView(senderDisplayName: String, messageContent: MessageContent) -> AnyView {
        var text = ""

        switch messageContent {
        case .text(let message),
             .unsupported(let message):
            text = message
        case .image( _):
            text = "Image"

        // EXPERIMENTAL
        case .html( _):
            text = "Html"
        case .widget( _):
            text = "Widget"
        }

        return AnyView((
            Text("\(senderDisplayName)")
                .font(.subheadline)
            + Text(" - \(text)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            )
            .lineLimit(3)
        )
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
