//
//  RoomViewModel.swift
//  MatrixSUI
//
//  Created by Emmanuel ROHEE on 14/08/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import UIKit
import Combine

class RoomViewModel: ObservableObject {
    @Published var roomName: String
    @Published var roomAvatar: String
    @Published var items: [RoomItem] = []

    let timeline: MessagesSourceType

    var timelineObserver: AnyCancellable?


    init(source: MessagesSourceType) {
        timeline = source
        roomName = "TODO"
        roomAvatar = "https://matrix.org/matrix.png"

        // TODO: Why this is required ?
        let message = Message(eventId: "11",
                sender:  "111",
                senderDisplayName: "WTF",
                content: .text(message: "Need a random message to make UI work. Why???"))

        items = makeItems(from: [message])

    }

    func start() {
        setupObservers()
        timeline.paginate()
    }

    func setupObservers() {
        timelineObserver = timeline.publisher
            .sink(receiveValue: { (update) in
                self.handle(update: update)
            })
    }

    func handle(update: MessagesUpdate) {
        switch update {
        case .backwards(let messages):
            items = makeItems(from: messages) + items
        case .forwards(let messages):
            items = items + makeItems(from: messages)
        case .update(_):
            // TODO
            break
        case .deletion(_):
            // TODO
            break
        }
    }

    func makeItems(from messages: [Message]) -> [RoomItem] {
        messages.map { message in
            .message(message: message)
        }
    }

}
