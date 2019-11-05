//
//  User.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 05/11/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import Foundation

struct User: Identifiable {
    var id: String {
        userId
    }

    var userId: String

    var displayname: String
    var avatar: String
}
