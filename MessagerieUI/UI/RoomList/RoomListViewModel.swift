//
//  RoomListModel.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 02/11/2019.
//  Copyright © 2019 Emmanuel ROHEE. All rights reserved.
//

import Foundation
import Combine

class RoomListViewModel: RoomListViewModelType {
    let state: RoomListViewState

    private let summariesSource: RoomSummariesSourceType
    private var summariesSourceObserver: AnyCancellable?

    private let userSource: UserSourceType
    private var userSourceObserver: AnyCancellable?

    private lazy var processingQueue: DispatchQueue = {
        DispatchQueue(label: "messagerie.RoomListViewModel")
       }()


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
        summariesSourceObserver = summariesSource.publisher
            .receive(on: processingQueue)
            .map({ (rooms) in
                rooms.sorted(by: { $0.lastMessageTs > $1.lastMessageTs })
            })
            .receive(on: RunLoop.main)
            .assign(to: \.rooms, on: self.state)

        summariesSource.load()

        userSourceObserver = userSource.publisher.sink { (user) in
            self.state.myUser = user
        }
        userSource.load()
    }
}

