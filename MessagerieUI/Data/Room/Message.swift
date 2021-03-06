//
//  MessageTextItem.swift
//  MatrixSUI
//
//  Created by Emmanuel ROHEE on 11/08/2019.
//  Copyright © 2019 Emmanuel ROHEE. All rights reserved.
//

import Foundation
import SwiftUI  // :/

struct MessageContentImage: Codable {
    let url: String
    let size: CGSize
}

enum MessageContent {
    case text(message: String)
    case image(imageModel: MessageContentImage)

    case unsupported(message: String)

    // EXPERIMENTAL
    case html(body: String)
    case widget(url: URL)
}

struct Message: Identifiable, Codable {

    var id: String {
        eventId
    }

    var eventId: String

    var sender: String
    var senderDisplayName: String
    var senderAvatar: String?

    var isIncoming: Bool = true

    var content: MessageContent

    var timestamp: UInt64
}
