//
//  AccountMananger.swift
//  Messagerie
//
//  Created by Emmanuel ROHEE on 01/11/2019.
//  Copyright © 2019 Emmanuel ROHEE. All rights reserved.
//

import Foundation

// Dumb implementation
class AccountManager: AccountManagerType {
    static let shared = AccountManager()
    
    private var accounts: [AccountType]

    init() {
        accounts = []
    }

    func getAccounts() -> [AccountType] {
        accounts
    }

    func addAccount(account: AccountType) {
        accounts.append(account)
    }

    func udpateAccount(account: AccountType) {
        // TODO
    }

    func removeAccount(protocolName: String, userId: String) {
        // TODO
    }
}
