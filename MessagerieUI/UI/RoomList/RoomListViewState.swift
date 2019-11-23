//
//  RoomListViewState.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 23/11/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import Foundation

class RoomListViewState: ObservableObject {

    @Published var rooms: [RoomSummary]?
    @Published var myUser: User?

    // TODO: Should not be required
    let account: AccountType

    init(account: AccountType) {
        self.account = account
    }
}
