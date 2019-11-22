//
//  ProtocolDataFactoryType.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 03/11/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import Foundation


// TODO: Can be cut into several protocols for better composition
protocol ProtocolDataFactoryType {

    func makeRoomSummariesSource(account: AccountType) -> RoomSummariesSourceType
    func makeTimeline(account: AccountType, roomId: String) -> MessagesSourceType
    func makeUserSource(account: AccountType, userId: String) -> UserSourceType

}

/// List of supported protocol (Matrix, Mock)
enum ProtocolName {
}
