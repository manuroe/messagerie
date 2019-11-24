//
//  RoomViewModel.swift
//  MatrixSUI
//
//  Created by Emmanuel ROHEE on 14/08/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import UIKit
import Combine

class RoomViewModel: RoomViewModelType {
    let state: RoomViewState

    let timeline: MessagesSourceType

    var timelineObserver: AnyCancellable?


    init(source: MessagesSourceType) {
        timeline = source
        state = RoomViewState(roomName: "TODO",
                              roomAvatar:"https://matrix.org/matrix.png")

        // TODO: Hide it. Why this is required ?
        let message = Message(eventId: "11",
                sender:  "111",
                senderDisplayName: "",
                content: .text(message: ""))

        state.items = makeItems(from: [message])

    }

    func process(action: RoomAction) {
        switch action {
        case .load:
            load()
        }
    }

    func load() {
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
            state.items = makeItems(from: messages) + state.items
        case .forwards(let messages):
            state.items = state.items + makeItems(from: messages)
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
