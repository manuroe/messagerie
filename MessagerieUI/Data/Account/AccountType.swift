//
//  Account.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 01/11/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import Foundation

protocol AccountType: Codable {
    var protocolName: String { get }
    var userId: String { get }
}
