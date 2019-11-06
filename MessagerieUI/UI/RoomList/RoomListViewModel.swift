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

    let account: Account
    private let summariesSource: RoomSummariesSource
    private var summariesSourceObserver: AnyCancellable?

    private let userSource: UserSource
    private var userSourceObserver: AnyCancellable?

    init(account: Account, source: RoomSummariesSource, userSource: UserSource) {
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

