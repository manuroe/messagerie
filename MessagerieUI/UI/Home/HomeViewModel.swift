//
//  HomeViewModel.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 12/11/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import SwiftUI

class HomeViewModel {
    let accountManager: AccountManagerType
    let state: HomeViewState

    init(accountManager: AccountManagerType) {
        self.accountManager = accountManager
        state = HomeViewState()
        reload()
    }

    func process(viewAction: HomeViewAction) {
        switch viewAction {
        case .reload:
            reload()
        case .addAccount(let account):
            addAccount(account: account)
        }
    }

    private func reload() {
        state.roomListViewModels = loadRoomListViewModels()
    }

    private func addAccount(account: AccountType) {
        let factoryManager = ProtocolDataFactoryManager.shared
        let dataFactory = factoryManager.factory(for: account.protocolName)!

        let roomSummariesSource = dataFactory.makeRoomSummariesSource(account: account)
        let userSource = dataFactory.makeUserSource(account: account, userId: account.userId)

        let roomListViewModel = RoomListViewModel(account: account, source: roomSummariesSource, userSource: userSource)

        state.roomListViewModels.append(roomListViewModel)
    }

    private func loadRoomListViewModels() -> [RoomListViewModel] {
        let factoryManager = ProtocolDataFactoryManager.shared

        return accountManager.getAccounts().map { account in
            let dataFactory = factoryManager.factory(for: account.protocolName)!

            let roomSummariesSource = dataFactory.makeRoomSummariesSource(account: account)
            let userSource = dataFactory.makeUserSource(account: account, userId: account.userId)

            return RoomListViewModel(account: account, source: roomSummariesSource, userSource: userSource)
        }
    }
}
