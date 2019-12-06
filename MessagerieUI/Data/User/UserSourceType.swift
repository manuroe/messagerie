//
//  UserSource.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 05/11/2019.
//  Copyright © 2019 Emmanuel ROHEE. All rights reserved.
//

import Foundation
import Combine

protocol UserSourceType {
    var publisher : AnyPublisher<User, Never> { get }

    func load()
}

