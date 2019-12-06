//
//  RoomListViewModelType.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 23/11/2019.
//  Copyright © 2019 Emmanuel ROHEE. All rights reserved.
//

import Foundation

protocol RoomListViewModelType {
    var state:RoomListViewState { get }

    func process(action: RoomListAction)
}
