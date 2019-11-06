//
//  ProtocolManager.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 03/11/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import Foundation


// TODO: Can be cut into several protocols for better composition
// Maybe TypeAlias?
// Name: dependency container or composition root
// Function builder: https://www.swiftbysundell.com/articles/the-swift-51-features-that-power-swiftuis-api/#function-builders
// https://basememara.com/swift-dependency-injection-via-property-wrapper/
// pod: https://github.com/square/Cleanse
protocol ProtocolManager {

    //func accountSource(account: Account) -> AccountSource

    func makeRoomSummariesSource(account: Account) -> RoomSummariesSource
    func makeTimeline(account: Account, roomId: String) -> MessagesSource
    func makeUserSource(account: Account, userId: String) -> UserSource

    //func roomSource(account: Account, roomId: String) -> RoomSource
}

struct ProtocolType {
}
