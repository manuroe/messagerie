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
    let roomService: RoomServiceType


    var timelineObserver: AnyCancellable?


    init(source: MessagesSourceType, roomService: RoomServiceType) {
        timeline = source
        self.roomService = roomService
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
        case .messageComposerAction(let action):
            sendMessage(action: action)
        }
    }


    private func load() {
        setupObservers()
        timeline.paginate()
    }

    private func sendMessage(action: MessageComposerAction) {
        switch action {
        case .textMessage(let message):
            _ = roomService.send(message: message)
        }
    }


    private func setupObservers() {
        timelineObserver = timeline.publisher
            .sink(receiveValue: { (update) in
                self.handle(update: update)
            })
    }

    private func handle(update: MessagesUpdate) {
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
