//
//  File.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 02/11/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import Foundation
import Combine

struct MockRoomSummariesSource: RoomSummariesSourceType {

    private let subject = PassthroughSubject<[RoomSummary], Never>()
    var publisher : AnyPublisher<[RoomSummary], Never> {
        return subject.eraseToAnyPublisher()
    }

    func load() {
        let rooms = [
            RoomSummary(roomId: "1", displayname: "Room #1", avatar: "https://matrix.org/matrix.png", lastMessageTs: 0),
            RoomSummary(roomId: "2", displayname: "Room #2", avatar: "https://matrix.org/matrix.png", lastMessageTs: 1),
            RoomSummary(roomId: "3", displayname: "Room #3", avatar: "https://matrix.org/matrix.png", lastMessageTs: 2),
        ]

        subject.send(rooms)
    }
}
