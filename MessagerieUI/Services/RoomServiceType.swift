//
//  RoomServiceType.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 25/11/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import Foundation
import Combine

protocol RoomServiceType {
    func send(message: String) -> AnyPublisher<String, Error>
}
