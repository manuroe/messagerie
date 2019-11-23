//
//  RoomListModel.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 02/11/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import Foundation
import Combine

class RoomListViewModel: RoomListViewModelType {
    let state: RoomListViewState

    private let summariesSource: RoomSummariesSourceType
    private var summariesSourceObserver: AnyCancellable?

    private let userSource: UserSourceType
    private var userSourceObserver: AnyCancellable?

    init(account: AccountType, source: RoomSummariesSourceType, userSource: UserSourceType) {
        self.summariesSource = source
        self.userSource = userSource
        self.state = RoomListViewState(account: account)
    }

    func process(action: RoomListAction) {
        switch action {
        case .load:
            load()
        }
    }

    private func load() {
        summariesSourceObserver = summariesSource.publisher.sink { (rooms) in
            self.state.rooms = rooms
        }
        summariesSource.load()

        userSourceObserver = userSource.publisher.sink { (user) in
            self.state.myUser = user
        }
        userSource.load()
    }
}

