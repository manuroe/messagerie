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
    @Published var messages: [Message] = []

    let timeline: MessagesSourceType

    var timelineObserver: AnyCancellable?


    init(source: MessagesSourceType) {
        self.timeline = source
        self.roomName = "TODO"
        self.roomAvatar = "https://matrix.org/matrix.png"

        // TODO: Why this is required ?
        self.messages = [
            Message(eventId: "11",
        sender:  "111",
        senderDisplayName: "WTF",
        content: .text(message: "Need a random message to make UI work. Why???"))
        ]
    }

    func start() {
        self.setupObservers()
        self.timeline.paginate()
    }

    func setupObservers() {
        self.timelineObserver = self.timeline.publisher
            .sink(receiveValue: { (update) in
                self.handle(update: update)
            })
    }

    func handle(update: MessagesUpdate) {
        switch update {
        case .backwards(let messages):
            self.messages = messages + self.messages
        case .forwards(let messages):
            self.messages = self.messages + messages
        case .update(_):
            // TODO
            break
        case .deletion(_):
            // TODO
            break
        }
    }

}
