//
//  RoomViewModel.swift
//  MatrixSUI
//
//  Created by Emmanuel ROHEE on 14/08/2019.
//  Copyright © 2019 Emmanuel ROHEE. All rights reserved.
//

import UIKit
import Combine

class RoomViewModel: RoomViewModelType {
    let state: RoomViewState

    let timeline: MessagesSourceType
    let roomService: RoomServiceType


    var timelineObserver: AnyCancellable?


    init(source: MessagesSourceType, roomService: RoomServiceType,
         // TODO
         roomName: String, roomAvatar: String) {
        timeline = source
        self.roomService = roomService
        state = RoomViewState(roomName: roomName,
                              roomAvatar: roomAvatar)

        enableWorkaround()
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
        checkWorkaround()

        switch update {
        case .backwards(let messages):
            state.items = state.items + makeItems(from: messages.reversed())
        case .forwards(let messages):
            state.items = makeItems(from: messages.reversed()) + state.items
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


    // TODO: Remove this
    // If fixes a blank display at the first display
    // Having a thing to display fix the issue
    private func enableWorkaround() {
        state.items = [.null]
    }
    private func checkWorkaround() {
        if let item = state.items.first, case .null = item {
            state.items.removeAll()
        }
    }
}
