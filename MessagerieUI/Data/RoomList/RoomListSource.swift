//
//  RoomListSource.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 02/11/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import Foundation
import Combine

protocol RoomListSource {
    // TODO: incremental update
    var publisher : AnyPublisher<[RoomSummary], Never> { get }

    func load()
}
