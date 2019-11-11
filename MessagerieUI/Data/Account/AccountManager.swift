//
//  AccountMananger.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 01/11/2019.
//  Copyright © 2019 manu.test. All rights reserved.
//

import Foundation

class AccountManager {

    static let shared = AccountManager()

    var accounts: [AccountType] = []

    init() {
    }

    func addAccount(account: AccountType) {
        accounts.append(account)
    }
}
