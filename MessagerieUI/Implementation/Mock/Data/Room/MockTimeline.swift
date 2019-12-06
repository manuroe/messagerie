//
//  MockTimeline.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 09/11/2019.
//  Copyright © 2019 Emmanuel ROHEE. All rights reserved.
//

import Foundation
import Combine

class MockTimeline: MessagesSourceType {

    private let subject = PassthroughSubject<MessagesUpdate, Never>()
    var publisher : AnyPublisher<MessagesUpdate, Never> {
        return subject.eraseToAnyPublisher()
    }

    func paginate(messagesCount: UInt, direction: Direction) {
        let messages = (1...messagesCount).map {
            makeMessage(index: index - $0)
        }
        index = index - messagesCount

        subject.send(.forwards(messages: messages))
    }

    private var index: UInt = 1000;
    private func makeMessage(index: UInt) -> Message {
        return Message(eventId: "\(index)",
            sender:  "\(index)",
            senderDisplayName: "Alice",
            senderAvatar: "https://placekitten.com/\(index)/\(index)",
            content: .text(message: "Message #\(index)"),
            timestamp: 1)
    }

}
