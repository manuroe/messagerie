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
protocol ProtocolManager {

    //func accountSource(account: Account) -> AccountSource

    func roomListSource(account: Account) -> RoomListSource
    //func roomSource(account: Account, roomId: String) -> RoomSource
}

struct ProtocolType {
}
