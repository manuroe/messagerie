//
//  RoomViewState.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 23/11/2019.
//  Copyright © 2019 Emmanuel ROHEE. All rights reserved.
//

import Foundation

class RoomViewState: ObservableObject {

    @Published var roomName: String
    @Published var roomAvatar: String
    @Published var items: [RoomItem] = []

    init(roomName: String, roomAvatar: String) {
        self.roomName = roomName
        self.roomAvatar = roomAvatar
    }
}
