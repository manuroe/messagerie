//
//  HomeViewState.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 18/11/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import Foundation

class HomeViewState: ObservableObject {

    @Published var roomListViewModels: [RoomListViewModel] = []
    @Published var index: Int = 0

    init() {
    }
}
