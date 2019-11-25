//
//  RoomViewItem.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 22/11/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import Foundation

enum RoomItem {
    // case dateHeader
    // case paginating
    // case readMarker
    // case timelineBreak // roomupgrade
    case message(message: Message)
    //case collapsed
    //case urlPreview
}

extension RoomItem: Identifiable {
    var id: String {
        switch self {
        case .message(let message):
            return message.id
        }
    }
}
