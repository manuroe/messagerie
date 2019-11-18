//
//  LoginViewAction.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 17/11/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import Foundation

enum LoginViewAction {
    case login(server: String? = nil, userId: String, password: String)
    case cancel
}
