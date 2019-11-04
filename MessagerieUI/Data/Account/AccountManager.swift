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

    var protocolManagers: [String: ProtocolManager] = [:]
    var accounts: [Account] = []


    init() {
    }

    func registerProtocolManager(protocolType: String, manager: ProtocolManager) {
        protocolManagers[protocolType] = manager
    }

    func manager(protocolType: String) -> ProtocolManager? {
         protocolManagers[protocolType]
    }

    func addAccount(account: Account) {
        accounts.append(account)
    }
}
