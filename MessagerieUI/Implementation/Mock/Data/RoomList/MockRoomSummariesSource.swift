//
//  File.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 02/11/2019.
//  Copyright © 2019 Emmanuel ROHEE. All rights reserved.
//

import Foundation
import Combine

struct MockRoomSummariesSource: RoomSummariesSourceType {

    private let subject = PassthroughSubject<[RoomSummary], Never>()
    var publisher : AnyPublisher<[RoomSummary], Never> {
        return subject.eraseToAnyPublisher()
    }

    func load() {
        // TODO
//        let rooms = [
//            RoomSummary(roomId: "1", displayname: "Room #1", avatar: "https://matrix.org/matrix.png"),
//            RoomSummary(roomId: "2", displayname: "Room #2", avatar: "https://matrix.org/matrix.png"),
//            RoomSummary(roomId: "3", displayname: "Room #3", avatar: "https://matrix.org/matrix.png"),
//        ]
//
//        subject.send(rooms)
    }
}
