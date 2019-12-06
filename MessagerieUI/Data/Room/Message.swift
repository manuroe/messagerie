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

extension MessageContent: Codable {

    private enum CodingKeys: String, CodingKey {
        case text, image
        case unsupported
        case html, widget
    }

    enum MessageContentCodingError: Error {
        case decoding(String)
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? values.decode(String.self, forKey: .text) {
            self = .text(message: value)
            return
        }
        if let value = try? values.decode(MessageContentImage.self, forKey: .image) {
            self = .image(imageModel: value)
            return
        }
        if let value = try? values.decode(String.self, forKey: .unsupported) {
            self = .unsupported(message: value)
            return
        }
        if let value = try? values.decode(String.self, forKey: .html) {
            self = .html(body: value)
            return
        }
        if let value = try? values.decode(URL.self, forKey: .widget) {
            self = .widget(url: value)
            return
        }
//        if let value = try? values.decode(String.self, forKey: .title) {
//            self = .title(value)
//            return
//        }
        throw MessageContentCodingError.decoding("Whoops! \(dump(values))")
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .text(let message):
            try container.encode(message, forKey: .text)
        case .image(let imageModel):
            try container.encode(imageModel, forKey: .image)
        case .unsupported(let message):
            try container.encode(message, forKey: .unsupported)
        case .html(let body):
            try container.encode(body, forKey: .html)
        case .widget(let url):
            try container.encode(url, forKey: .widget)
        }
    }
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
