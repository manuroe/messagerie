//
//  RoomListModel.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 02/11/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import Foundation
import Combine

class RoomListViewModel: ObservableObject {
    @Published var rooms: [RoomSummary]?
    @Published var myUser: User?

    let account: AccountType
    private let summariesSource: RoomSummariesSourceType
    private var summariesSourceObserver: AnyCancellable?

    private let userSource: UserSourceType
    private var userSourceObserver: AnyCancellable?

    init(account: AccountType, source: RoomSummariesSourceType, userSource: UserSourceType) {
        self.account = account
        self.summariesSource = source
        self.userSource = userSource
        load()
    }

    private func load() {
        summariesSourceObserver = summariesSource.publisher.sink { (rooms) in
            self.rooms = rooms
        }
        summariesSource.load()

        userSourceObserver = userSource.publisher.sink { (user) in
            self.myUser = user
        }
        userSource.load()
    }
}

