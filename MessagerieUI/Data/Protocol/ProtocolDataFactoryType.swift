//
//  ProtocolDataFactoryType.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 03/11/2019.
//  Copyright © 2019 Emmanuel ROHEE. All rights reserved.
//

import Foundation


// TODO: Can be cut into several protocols for better composition
protocol ProtocolDataFactoryType {

    // - MARK: Data

    func makeRoomSummariesSource(account: AccountType) -> RoomSummariesSourceType
    func makeTimeline(account: AccountType, roomId: String) -> MessagesSourceType
    func makeUserSource(account: AccountType, userId: String) -> UserSourceType


    // To move
    // - MARK: Service
    func makeRoomService(account: AccountType, roomId: String) -> RoomServiceType
}

/// List of supported protocol (Matrix, Mock)
enum ProtocolName {
}
