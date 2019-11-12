//
//  HomeViewModel.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 12/11/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import SwiftUI

class HomeViewModel: ObservableObject {

    let accountManager: AccountManager

    @Published var roomListViewModels: [RoomListViewModel] = []

    init(accountManager: AccountManager) {
        self.accountManager = accountManager
        roomListViewModels = loadRoomListViewModels()
    }

    private func loadRoomListViewModels() -> [RoomListViewModel] {
        let factoryManager = ProtocolDataFactoryManager.shared

        return accountManager.accounts.map { account in
            let dataFactory = factoryManager.factory(for: account.protocolName)!

            let roomSummariesSource = dataFactory.makeRoomSummariesSource(account: account)
            let userSource = dataFactory.makeUserSource(account: account, userId: account.userId)

            return RoomListViewModel(account: account, source: roomSummariesSource, userSource: userSource)
        }
    }
}
