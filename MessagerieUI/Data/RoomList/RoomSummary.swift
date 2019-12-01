//
//  RoomSummary.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 02/11/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import Foundation

// TODO: Find better name (RoomViewItem?, Room?)
struct RoomSummary: Identifiable {
    var id: String {
        roomId
    }

    var roomId: String

    var displayname: String
    var avatar: String

    var lastMessageTs: UInt64
    var lastMessage: Message?
}
