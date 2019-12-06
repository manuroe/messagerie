//
//  RoomListSource.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 02/11/2019.
//  Copyright © 2019 Emmanuel ROHEE. All rights reserved.
//

import Foundation
import Combine

enum Direction {
    case backwards
    case forwards
}

/// Timeline, search result, notifications view
protocol MessagesSourceType {

    var publisher : AnyPublisher<MessagesUpdate, Never> { get }

    func paginate(messagesCount: UInt, direction: Direction)
}

extension MessagesSourceType {
    func paginate(messagesCount: UInt = 30) {
        paginate(messagesCount: messagesCount, direction: .backwards)
    }
}
