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

    private let source: RoomSummariesSource
    private var sourceObserver: AnyCancellable?

    init(source: RoomSummariesSource) {
        self.source = source
        load()
    }

    private func load() {
        sourceObserver = source.publisher.sink { (rooms) in
            self.rooms = rooms
        }

        source.load()
    }
}

