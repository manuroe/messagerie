//
//  MessageTextView.swift
//  MatrixSUI
//
//  Created by Emmanuel ROHEE on 11/08/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import SwiftUI

struct MessageView: View {
    var message: Message

    var body: some View {
        HStack (alignment: .top) {
            AvatarView(avatar: message.senderAvatar, width: 40, height: 40)
                .padding(.leading, 8)

            VStack (alignment: .leading) {
                Text(message.senderDisplayName)
                    .font(.headline)
                    .lineLimit(nil)
                    .foregroundColor(.red)

                self.messageContentView(messageContent: message.content)
            }
        }
    }

    func messageContentView(messageContent: MessageContent) -> AnyView {
        switch messageContent {
            case .text(let message):
                return AnyView(
                    MessageTextView(message: message)
                )
            case .image(let imageModel):
                return AnyView(
                    MessageImageView(urlString: imageModel.url)
                )

            case .unsupported(let message):
                return AnyView(
                    MessageTextView(message: message)
                )

            // EXPERIMENTAL
            case .html(let body):
                return AnyView(
                    MessageHtmlView(html: body)
                )
            case .widget(let url):
                return AnyView(
                    MessageWidgetView(url: url)
                )
            }
        }
    }

#if DEBUG
struct MessageView_Previews: PreviewProvider {
    static let message = Message(eventId: "1",
                                 sender: "alice",
                                 senderDisplayName: "Alice",
                                 senderAvatar: "mxc://GwLdwtwfVETgQNZtUvrEzkAC",
                                 content: .text(message: "Hello"))

    static var previews: some View {
        MessageView(message: message)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
}
#endif

